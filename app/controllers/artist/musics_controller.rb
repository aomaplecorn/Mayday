class Artist::MusicsController < ApplicationController

  def new
    # @album = Album.find(params[:album_id])
    # @music = @album.musics.build

  end

  def create
    @music = Music.new(music_params)
    @music.save
  end

  def index
    @musics = Music.all
  end

  def show
  end

  def edit
  end

  private
  def music_params
    params.require(:music).permit(:name,:price,:audio,:artist_id,:index_info,:album_id,:track)
  end


end
