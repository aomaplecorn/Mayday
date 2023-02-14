class Artist::ItemsController < ApplicationController
  before_action :authenticate_artist!

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to artist_items_path
    else
      render :new
    end
  end

  def index
    @items = current_artist.items.all
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to artist_items_path
    else
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    if @item.destroy
     redirect_to artist_items_path
    else
      render :edit
    end
  end

  private
  def item_params
    params.require(:item).permit(:name,:introduction,:amount,:price,:is_active,:artist_id,:item_image)
  end

end
