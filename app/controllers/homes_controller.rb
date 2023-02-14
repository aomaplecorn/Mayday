class HomesController < ApplicationController

  def top
  end

  def home
    @artists = Artist.where(is_deleted: false).order(updated_at: :desc).last(3)
    @albums = Album.where(released: true).order(updated_at: :desc).last(3)
    @items = Item.where(is_active: true).order(created_at: :desc).last(3)
  end

  # 検索機能（対象：アイテム・アルバム・アーティスト）
  def search
    @items = Item.search(params[:keyword]).where(is_active: true).page(params[:page]).per(8).order(created_at: :desc)
    @albums = Album.search(params[:keyword]).where(released: true).page(params[:page]).per(8).order(created_at: :desc)
    @artists = Artist.search(params[:keyword]).where(is_deleted: false).page(params[:page]).per(8).order(created_at: :desc)
    render :search
  end
end
