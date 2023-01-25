class Artist::AlbumsController < ApplicationController

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    @album.save
    redirect_to artist_album_path(@album.id)
  end

  def index
    @albums = Album.all
  end

  def show
    @album = Album.find(params[:id])
    #@musicsにalbum.idが同じものを格納。一つのalbum_idのみ表示されるようにする。
    # @album.musics.each do |album_musics|
    #   if album_musics.album_id == @album.id
        # @musics = album_musics
        @musics = @album.musics
      # end
    # end
    @music = Music.new
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])
    @album.update(album_params)
    redirect_to artist_album_path(@album.id)
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to artist_albums_path
  end


  private
  def album_params
    params.require(:album).permit(:name,:price,:released,:editor_id,:jacket_image)
  end

end
