class Artist::UsersController < ApplicationController
  before_action :authenticate_artist!

  def show
    @artist = current_artist
  end

  def edit
    @artist = current_artist
  end

  def update
    @artist = current_artist
    @artist.update(artist_params)
    redirect_to artist_mypage_path
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
    params.require(:artist).permit(:name,:introduction,:telephone_number,:background_image,:introduction_image)
  end

end
