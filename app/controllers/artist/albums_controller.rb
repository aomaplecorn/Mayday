class Artist::AlbumsController < ApplicationController
  before_action :authenticate_artist!
  # アクセス制限（自分以外のアーティストがアクセスできないようにする）
  before_action :ensure_current_artist, only: [:show, :edit, :update, :destroy]
  # アクセス制限（ゲスト不可）
  # before_action :guest_check, only: [:create,:update,:destroy]

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to edit_artist_album_path(@album.id)
    else
      render :new
    end
  end

  def index
    @albums = current_artist.albums.page(params[:page]).per(10).order(created_at: :desc)
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
    if @album.update(album_params)
      redirect_to artist_album_path(@album.id)
    else
      @musics = @album.musics
      @music = Music.new
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to artist_albums_path
  end


  private
  def album_params
    params.require(:album).permit(:name,:price,:released,:artist_id,:jacket_image)
  end

    # アクセス制限（自分以外のアーティストがアクセスできないようにする）
  def ensure_current_artist
    if current_artist.id != Album.find(params[:id]).artist.id
      flash[:notice] = "権限がありません"
      redirect_to artist_albums_path
    end
  end

  # アクセス制限（ゲスト不可）
  def guest_check
    if current_artist.id == 1
      flash[:notice] = "ゲストアカウントでは行えません"
      redirect_to home_path
    end
  end

end
