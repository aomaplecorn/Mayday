class Admin::UsersController < ApplicationController
  def index
    @artists = Artist.all
    @customers = Customer.all
  end

  def update
    @artist = Artist.find(params[:id])
    @artist.update(artist_params)
    redirect_to admin_users_path
  end

  private
  def artist_params
    params.require(:artist).permit(:name,:telephone_number,:is_deleted)
  end

  def customer_params
    params.require(:customer).permit(:is_deleted)
  end
end
