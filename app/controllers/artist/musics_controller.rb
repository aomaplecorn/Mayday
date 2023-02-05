class Artist::MusicsController < ApplicationController
  before_action :authenticate_artist!

  def create
    @music = Music.new(music_params)
    @music.save
    redirect_to edit_artist_album_path(@music.album_id)
  end

  def update
    @music = Music.find(params[:id])
    if @music.update(music_params)
    # アルバム編集画面へ戻る
      redirect_to edit_artist_album_path(@music.album_id)
    else
      redirect_to artist_album_path(@music.album_id)
    end
  end

  def destroy
    @music = Music.find(params[:id])
    @music.destroy
    # アルバム編集画面へ戻る
    redirect_to edit_artist_album_path(@music.album_id)
  end

  private
  def music_params
    params.require(:music).permit(:name,:price,:audio,:artist_id,:index_info,:album_id,:track,:test_audio)
  end


end
