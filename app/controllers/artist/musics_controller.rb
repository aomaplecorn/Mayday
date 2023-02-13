class Artist::MusicsController < ApplicationController
  before_action :authenticate_artist!

  def create
    @music = Music.new(music_params)
    @track_check = @music.album.musics.find_by(track: @music.track)
    # 同じトラック番号がないか確認。
    if @track_check == nil || @track_check.track != @music.track
      if @music.save
        redirect_to edit_artist_album_path(@music.album_id)
      else
        @album = @music.album
        @musics = @album.musics
        render '/artist/albums/edit'
      end
    else
      @album = @music.album
      @musics = @album.musics
      flash[:notice_create] = "同じトラック番号があります"
      render '/artist/albums/edit'
    end
  end

  def update
    @music = Music.find(params[:id])
    # パラムス内のtrackを引き出し変数へ格納。
    @params_track_check  = Music.new(music_params)
    @music_track_check = @music.album.musics.find_by(track: @params_track_check.track)
    # 同じトラック番号がないか確認。
    if @music_track_check == nil || @music_track_check.track != @params_track_check.track
      if @music.update(music_params)
      # アルバム編集画面へ戻る
        redirect_to edit_artist_album_path(@music.album_id)
      else
        @album = @music.album
        @musics = @album.musics
        render '/artist/albums/edit'
      end
    else
      @album = @music.album
      @musics = @album.musics
      flash[:notice_update] = "同じトラック番号があります"
      render '/artist/albums/edit'
    end
  end

  def destroy
    @music = Music.find(params[:id])
    @music.destroy
    redirect_to edit_artist_album_path(@music.album_id)
  end

  private
  def music_params
    params.require(:music).permit(:name,:audio,:artist_id,:index_info,:album_id,:track,:test_audio)
  end


end
