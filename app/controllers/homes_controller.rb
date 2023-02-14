class HomesController < ApplicationController
  before_action :authenticate_customer!, only: [:search,:home]

  def top
  end

  def home
    @artists = Artist.where(is_deleted: false).order(updated_at: :desc).last(3)
    @albums = Album.where(released: true).order(updated_at: :desc).last(3)
    @items = Item.where(is_active: true).order(created_at: :desc).last(3)
  end

  # 検索機能（対象：アイテム・アルバム・アーティスト）
  def search
    @items = Item.search(params[:keyword])
    @albums = Album.search(params[:keyword])
    @artists = Artist.search(params[:keyword])
    @search_items = @items.page(params[:page]).per(8)
    @search_albums = @albums.page(params[:page]).per(8)
    @search_artists = @artists.page(params[:page]).per(8)
    @keyword = params[:keyword]
    render :search
  end


end
