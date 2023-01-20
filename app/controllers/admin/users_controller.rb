class Admin::UsersController < ApplicationController

  def index
    @artists = Artist.all
    @customers = Customer.all
  end
# updateの分岐製作中
  def update
    # index（ユーザー一覧）から送られてきた情報でaddress（artistにはないカラム）が空であれば「artistのステータス更新」を実行
    if @customer = Customer.find(params[:id]).address == nil
    ## artistのステータス更新
      @artist = Artist.find(params[:id])
      @artist.update(artist_params)
      redirect_to admin_users_path
    else
    ## customerのステータス更新
      @customer = Customer.find(params[:id])
      @customer.update(customer_params)
      redirect_to admin_users_path
    end
  end

  private
  def artist_params
    params.require(:artist).permit(:name,:telephone_number,:is_deleted)
  end

  def customer_params
    params.require(:customer).permit(:name,:name_kana,:postal_code,:address,:telephone_number,:is_deleted)
  end
end
