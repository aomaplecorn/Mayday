class Customer::OrdersController < ApplicationController
  before_action :authenticate_customer!
  require 'payjp'

  def new
    @order = Order.new
    # URL直接入力対策（カートにアイテムがない場合、カート画面に戻る）
    if current_customer.cart_items.count == 0
      redirect_to customer_cart_items_path
    end
  end

  def confirm
  ## 以下、カートアイテムが　有る　場合の処理
    if current_customer.cart_items != nil
      @order = Order.new(order_params)
      @order.customer_id = current_customer.id
    ## 以下、confirm画面で表示する金額を用意する処理
      @cart_items = current_customer.cart_items
      # カート内の合計金額を格納
      @total_item_price = @cart_items.inject(0) { |total, item| total + item.subtotal }
    ## 以下、送料合計を@total_delivery_costへ格納
      # total_delivery_costの数値を０にしておく
      @total_delivery_cost = 0
      @cart_items.each do |cart_item|
        # カートアイテムに入っているアイテムに設定された各送料を@total_delivery_costへ格納
        @total_delivery_cost += cart_item.item.artist.delivery_cost
      end
    ## ここまで、送料合計を@total_delivery_costへ格納
      # オーダーのdelivery_costに格納
      @order.delivery_cost = @total_delivery_cost
      # カート内のアイテム＋送料の総額を、請求金額(total_payment)へ格納
      @order.total_payment = @total_item_price + @order.delivery_cost
    ## ここまで、confirm画面で表示する金額を用意する処理

    ## 以下、view/new　で定義した address_number（１）＝「ご自身の住所」　の処理
      if params[:order][:address_number] == "1"
        @order.postal_code = current_customer.postal_code
        @order.address = current_customer.address
        @order.name = current_customer.name
    ## 以下、view/new　で定義した address_number（２）＝「登録した住所以外へ届ける」　の処理
      elsif params[:order][:address_number] == "2"
        # 郵便番号、住所、宛名から入力内容前後の空白をstripを使って除去。
        @order.postal_code = @order.postal_code.strip
        @order.address = @order.address.strip
        @order.name = @order.name.strip
        # 郵便番号、住所、宛名に何も入っていない場合はオーダー作成へ戻る
        if @order.postal_code == "" || @order.address == "" || @order.name == ""
          flash[:notice_2] = "お届け先に必要な情報を入力してください"
          redirect_to new_customer_order_path
        end
    ## 以下、view/new　で定義した address_numberを選択しなかった場合　の処理
      else
        flash[:notice_1] = 'お届け先を選択してください'
        redirect_to new_customer_order_path
      end
  ## ここまで、カートアイテムが　有る　場合の処理
  ## 以下、カートアイテムが　無い 場合の処理（カートへ戻る）
    else
      redirect_to customer_cart_items_path
    end
  end

  # アイテム購入処理
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    if @order.save
    # 決済処理（Payjpを使用）
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']
        @charge = Payjp::Charge.create(
          # 決済する値段
          amount: @order.total_payment,
          # フォームを送信すると作成・送信されてくるトークン
          card: params['payjp-token'],
          currency: 'jpy',
          )
    # ユーザーのカートアイテムをcart_itemsへ格納
      cart_items = current_customer.cart_items.all
    # カート情報をもとに、注文詳細（OrderDetail）を作成し保存
      cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        # 支払いIDを注文詳細に持たせて、決済番号を控えさせる。
        order_detail.charge_id = @charge.id
        order_detail.order_id = @order.id
        order_detail.item_id = cart_item.item_id
        order_detail.price = cart_item.item.price
        order_detail.amount = cart_item.amount
        order_detail.save
        # アイテムIDを取得し、アイテムモデルから各アイテムの在庫（amount）を減少させる。
        @item = Item.find(cart_item.item_id)
        @item.amount -= cart_item.amount
        @item.save
      end
      cart_items.destroy_all
      redirect_to customer_order_complete_path
    else
      render :new
    end
  end

  # 注文履歴一覧
  def index
    # カスタマー1人の一覧を降順（最新が一番上）で取得
    @orders = current_customer.orders.order(created_at: :desc)
    @order_details = OrderDetail.all
    # アイテムの注文詳細を全て取得
    @item_order_details = OrderDetail.where(album_id: nil)
    # アルバムの注文詳細を全て取得
    @album_order_details = OrderDetail.where(album_id: !nil)
  end

  # 注文履歴詳細
  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.all
  # 商品合計を逆算
    @total_price = @order.total_payment - @order.delivery_cost
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :delivery_cost, :total_payment, :status)
  end

end
