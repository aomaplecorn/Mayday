class Artist::AlbumsController < ApplicationController

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    @album.save
    redirect_to new_artist_music_path
  end

  def index
    @albums = Album.all
  end

  def show
    @album = Album.find(params[:id])
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

  end


  private
  def album_params
    params.require(:album).permit(:name,:price,:released,:editor_id)
  end

end
