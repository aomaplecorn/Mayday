# frozen_string_literal: true

class Customer::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :customer_state, only: [:create]

  def after_sign_in_path_for(resource)
    flash[:notice] = 'ログインしました。'
    home_path
  end

  def after_sign_out_path_for(resource)
    flash[:notice] = 'ログアウトしました。'
    "/"
  end

  # ゲストログイン
  def new_guest
    customer = Customer.guest
    sign_in customer
    flash[:notice] = 'ゲストカスタマーとしてログインしました。'
    home_path
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  ## 以下、退会処理
  def customer_state
    # 入力されたemailからアカウントを１件取得
    @customer = Customer.find_by(email: params[:customer][:email])
    # アカウントを取得できなかった場合、このメソッドを終了
    return if !@customer
    # 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
    if @customer.valid_password?(params[:customer][:password]) && @customer.is_deleted
      redirect_to new_customer_registration_path
    end
  end
  ## ここまで、退会処理

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
