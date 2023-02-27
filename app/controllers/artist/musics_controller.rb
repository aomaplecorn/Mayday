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
        flash[:notice] = "新規作成できませんでした"
        render '/artist/albums/edit'
      end
    else
      @album = @music.album
      @musics = @album.musics
      flash[:notice] = "同じトラック番号があります"
      render '/artist/albums/edit'
    end
  end

  def update
    @music = Music.find(params[:id])
    # パラムス内のtrackを変数へ格納
    @music_params  = Music.new(music_params)

    @track_check = @music.album.musics.find_by(track: @music_params.track)
    # 「同じトラック番号がないか＋IDが同じであること」を確認
    if @track_check == nil || @track_check.track != @music_params.track || @track_check.id == @music.id
      if @music.update(music_params)
      # アルバム編集画面へ戻る
        redirect_to edit_artist_album_path(@music.album_id)
      else
        @album = @music.album
        @musics = @album.musics
        flash[:notice] = "変更が行えませんでした"
        render '/artist/albums/edit'
      end
    else
      @album = @music.album
      @musics = @album.musics
      flash[:notice] = "同じトラック番号があります"
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
