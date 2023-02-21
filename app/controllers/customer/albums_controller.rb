class Customer::AlbumsController < ApplicationController
  before_action :authenticate_customer!, only: [:create]
  # アクセス制限（ゲスト不可）
  before_action :guest_check, only: [:create]

  def index
    @albums = Album.where(released: true).page(params[:page]).per(9).order(created_at: :desc)
  end

  def show
    @album = Album.find(params[:id])
    @musics = @album.musics
    @order = Order.new
  end

# アルバム購入処理
  def create
    @album = Album.new(album_params)
    # 注文詳細を表示するためにオーダーを作成し保存する。
    @order = Order.new
    @order.customer_id = current_customer.id
    @order.artist_id = @album.artist_id
    @order.delivery_cost = 0
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.name
    @order.total_payment = @album.price

    if @order.save
    # 決済処理（Payjpを使用）
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']
        @charge = Payjp::Charge.create(
        # 決済する値段
        amount: @album.price,
        # フォームを送信すると作成・送信されてくるトークン
        card: params['payjp-token'],
        currency: 'jpy',
        )
      # 注文詳細（OrderDetail）を作成し保存
      order_detail = OrderDetail.new
      # 支払いIDを注文詳細に持たせて、決済番号を控えさせる。
      order_detail.charge_id = @charge.id
      order_detail.order_id = @order.id
      order_detail.album_id = @album.id
      order_detail.price = @album.price
      order_detail.save
      redirect_to customer_order_complete_path
    else
      redirect_to customer_orders_path
    end
  end

  private
  def album_params
    params.require(:album).permit(:id,:price,:artist_id)
  end

  # アクセス制限（ゲスト不可）
  def guest_check
    if current_customer.id == 1
      flash[:notice] = "ゲストアカウントでは行えません"
      redirect_to home_path
    end
  end


end
