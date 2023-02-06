class Customer::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items
    @cart_item = CartItem.new
    # 商品の合計金額
    @total_item_price = @cart_items.inject(0) { |total, item| total }
    # 配送料合計
    @total_delivery_cost = @cart_items.inject(0) { |total, item| total }
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    # カート内にある同じアイテムのレコードを取得し、既存のカートアイテム（existing_cart_item）へ格納
    @existing_cart_item = current_customer.cart_items.find_by(item_id: @cart_item.item_id)
    # カート内に同じアイテムがない場合、レコードを新規作成する
    if @existing_cart_item == nil
      @cart_item.save
      redirect_to customer_cart_items_path
    # カート内に同じアイテムがある場合、レコードの"数量"を更新する
    elsif @cart_item.amount != nil
      ## アイテムの個数が在庫を超えた場合、アイテム画面へリダイレクトする条件分岐。
      if @existing_cart_item.amount > @cart_item.item.amount
        @existing_cart_item.amount += @cart_item.amount
        @existing_cart_item.save
        redirect_to customer_cart_items_path
      else
        flash[:notice_stock_error] = "在庫以上のご注文はできません"
        redirect_to customer_item_path(@cart_item.item_id)
      end
    else
    # 選択肢を間違えた時＋「個数選択」を選択した場合
      redirect_to customer_item_path(@cart_item.item_id)
    end
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
end

