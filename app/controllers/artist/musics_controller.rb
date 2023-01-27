class Artist::MusicsController < ApplicationController

  def create
    @music = Music.new(music_params)
    @music.save
  end

  def update
    @music = Music.find(params[:id])
    @music.update(music_params)
    # アルバム編集画面へ戻る
    redirect_to edit_artist_album_path(@music.album_id)
  end

  def destroy
    @music = Music.find(params[:id])
    @music.destroy
    # アルバム編集画面へ戻る
    redirect_to edit_artist_album_path(@music.album_id)
  end

  private
  def music_params
    params.require(:music).permit(:name,:price,:audio,:artist_id,:index_info,:album_id,:track)
  end


end
