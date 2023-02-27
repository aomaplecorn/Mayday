class Artist::ItemsController < ApplicationController
  before_action :authenticate_artist!
  # アクセス制限（自分以外のアーティストがアクセスできないようにする）
  before_action :ensure_current_artist, only: [:edit, :update, :destroy]
  # アクセス制限（ゲスト不可）
  # before_action :guest_check, only: [:create,:update,:destroy]

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to artist_items_path
    else
      render :new
    end
  end

  def index
    @items = current_artist.items.page(params[:page]).per(8).order(created_at: :desc)
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to artist_items_path
    else
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    if @item.destroy
     redirect_to artist_items_path
    else
      render :edit
    end
  end

  private
  def item_params
    params.require(:item).permit(:name,:introduction,:amount,:price,:is_active,:artist_id,:item_image)
  end

  # アクセス制限（自分以外のアーティストがアクセスできないようにする）
  def ensure_current_artist
    if current_artist.id != Item.find(params[:id]).artist.id
      flash[:notice] = "権限がありません"
      redirect_to artist_items_path
    end
  end

  # アクセス制限（ゲスト不可）
  def guest_check
    if current_artist.id == 1
      flash[:notice] = "ゲストアカウントでは行えません"
      redirect_to home_path
    end
  end

end
