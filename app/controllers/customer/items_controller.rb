class Customer::ItemsController < ApplicationController

  def index
    @items = Item.where(is_active: true).page(params[:page]).per(9).order(created_at: :desc)
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

end
