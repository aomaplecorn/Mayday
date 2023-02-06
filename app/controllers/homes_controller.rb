class HomesController < ApplicationController
  def top
  end

  require 'payjp'

  def purchase
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    @charge = Payjp::Charge.create(
      amount: 812, # 決済する値段
      # customer: current_user.id,
      card: params['payjp-token'], # フォームを送信すると作成・送信されてくるトークン
      currency: 'jpy'
    )
    # binding.pry
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
