class Artist::MusicsController < ApplicationController

  def new
    @music = Music.new
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
    params.require(:music).permit(:name,:price,:audio)
  end


end
