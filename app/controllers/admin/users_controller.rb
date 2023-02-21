class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @artists = Artist.page(params[:page]).per(30)
    @customers = Customer.page(params[:page]).per(30)
  end

  # artistのステータス更新
  def artist_update
    @artist = Artist.find(params[:id])
    @artist.update(artist_params)
    redirect_to admin_users_path
  end

  # customerのステータス更新
  def customer_update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to admin_users_path
  end

  private
  def artist_params
    params.require(:artist).permit(:is_deleted)
  end

  def customer_params
    params.require(:customer).permit(:is_deleted)
  end
end
