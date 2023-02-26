class Customer::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  # アクセス制限（ゲスト不可）
  # before_action :guest_check

  def index
    @cart_item = CartItem.new
    @cart_items = current_customer.cart_items
    if @cart_items.count == 0
      @delivery_cost = 0
    else
      @delivery_cost = @cart_items.first.item.artist.delivery_cost
    end
    # 商品の合計金額
    @total_price = @cart_items.inject(0) { |total, item| total }
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    # 「個数選択」を選択した場合はリダイレクト
    if @cart_item.amount == nil
      flash[:notice] = "数量を選択してください"
      redirect_to customer_item_path(@cart_item.item_id) and return
    end
  # 以下、カート内のアイテム有無判定
    ## カート内にある同じアイテムのレコードを取得し、既存のカートアイテム（existing_cart_item）へ格納
    @existing_cart_item = current_customer.cart_items.find_by(item_id: @cart_item.item_id)
    ## 条件１、カート内に同じアイテムがない場合、レコードを新規作成する
    if @existing_cart_item == nil
      ### 条件１−１、カート内にレコードがない場合     ＝セーブ
      if current_customer.cart_items.count == 0
        @cart_item.save
        redirect_to customer_cart_items_path and return
      ### 条件１−２、カート内にレコードがある場合     ＝次の条件分岐（同じアーティストかどうか）へ
      else
        #### 条件１−２−１、カートのレコードが同じアーティストのものである場合     ＝セーブ
        if @cart_item.item.artist_id == current_customer.cart_items.first.item.artist_id
          @cart_item.save
          redirect_to customer_cart_items_path and return
        #### 条件１−２−２、カートのレコードが同じアーティストのものではない場合   ＝リダイレクト
        else
            flash[:notice] = "他のアーティストの商品がカートに入っています。カート内にある商品の購入処理を済ませてからお買い求めください。"
            redirect_to customer_item_path(@cart_item.item_id) and return
        end
      end
    ## 条件２、カート内に同じアイテムがある場合、レコードの"数量"を更新する
    elsif @cart_item.amount != nil
      @existing_cart_item.amount += @cart_item.amount
      ### 条件２−１、アイテムの個数が　在庫以下＝保存。
      if @existing_cart_item.amount <= @cart_item.item.amount
        @existing_cart_item.save
        redirect_to customer_cart_items_path and return
      ### 条件２−２、アイテムの個数が　在庫以上＝アイテム画面へ戻る。
      else
        flash[:notice] = "在庫以上のご注文はできません"
        redirect_to customer_item_path(@cart_item.item_id) and return
      end
    end
  # ここまで、カート内のアイテム有無判定
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to customer_cart_items_path
    else
      render :index
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    if @cart_item.destroy
      redirect_to customer_cart_items_path
    else
      render :index
    end
  end

  def destroy_all
    if current_customer.cart_items.destroy_all
      redirect_to customer_cart_items_path
    else
      render :index
    end
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end

  # アクセス制限（ゲスト不可）
  def guest_check
    if current_customer.id == 1
      flash[:notice] = "ゲストアカウントでは行えません"
      redirect_to home_path
    end
  end

end

