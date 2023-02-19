class Artist::OrdersController < ApplicationController
  before_action :authenticate_artist!
  before_action :ensure_current_artist, only: [:show, :update]

  def index
    # アーティスト1人のアルバムの注文を全て取得（降順（最新が一番上））
    @album_orders = current_artist.orders.left_joins(:order_details).where(order_details: {item_id: nil}).order(created_at: :desc)
    # アーティスト1人のアイテムの注文を全て取得（降順（最新が一番上））
    item_orders = current_artist.orders.left_joins(:order_details).where(order_details: {album_id: nil}).order(created_at: :desc)
    # アイテムの重複したレコードをdistinctで削除する。
    @item_orders = item_orders.distinct
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:notice] = "ステータスが更新されました"
      redirect_to artist_order_path(@order.id)
    else
      flash[:notice] = "ステータスの更新に失敗しました"
      render :show
    end
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end

    # アクセス制限（自分以外のアーティストがアクセスできないようにする）
  def ensure_current_artist
    if current_artist.id != Order.find(params[:id]).artist.id
      flash[:notice] = "権限がありません"
      redirect_to artist_orders_path
    end
  end


end
