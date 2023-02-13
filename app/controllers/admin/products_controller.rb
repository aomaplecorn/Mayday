class Admin::ProductsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @items = Item.all
    @albums = Album.all
  end

  def item_show
    @item = Item.find(params[:id])
  end

  def album_show
    @album = Album.find(params[:id])
    @musics = @album.musics
  end

  def item_destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to admin_products_path
  end

  def album_destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to admin_products_path
  end

end
