class Customer::UsersController < ApplicationController
  before_action :authenticate_customer!

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customer_mypage_path
    else
      render :edit
    end
  end

  # 以下、退会機能
  def check
    @customer = current_customer
  end

  def withdraw
    @customer = current_customer
    if @customer.update(is_deleted: true)
      reset_session
      redirect_to "/"
    else
      render :check
    end
  end
  # ここまで、退会機能

  private
  def customer_params
    params.require(:customer).permit(:name,:name_kana,:postal_code,:address,:telephone_number)
  end
end
