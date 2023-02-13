class Artist::UsersController < ApplicationController
  before_action :authenticate_artist!, except: [:show]

  def show
    @artist = Artist.find(params[:id])
    # アルバム・アイテムの販売中になっている最新３件を取得
    @albums = @artist.albums.where(released: true).last(4)
    @items = @artist.items.where(is_active: true).last(4)
  end

  def edit
    @artist = current_artist
  end

  def update
    @artist = current_artist
    if @artist.update(artist_params)
      redirect_to artist_user_path(@artist.id)
    else
      render :edit
    end
  end

  # 以下、退会機能
  def check
    @artist = current_artist
  end

  def withdraw
    @artist = current_artist
    if @artist.update(is_deleted: true)
      reset_session
      redirect_to "/"
    else
      render :check
    end
  end
  # ここまで、退会機能

  private
  def artist_params
    params.require(:artist).permit(:name,:introduction,:telephone_number,:background_image,:introduction_image,:delivery_cost)
  end

end
