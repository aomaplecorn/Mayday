class Artist::AlbumsController < ApplicationController

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    @album.save
    redirect_to edit_artist_album_path(@album.id)
  end

  def index
    @albums = Album.all
  end

  def show
    @album = Album.find(params[:id])
    @musics = @album.musics
  end

  def edit
    @album = Album.find(params[:id])
    @musics = @album.musics
    @music = Music.new
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
