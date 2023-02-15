# frozen_string_literal: true

class Artist::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :artist_state, only: [:create]

  def after_sign_in_path_for(resource)
    flash[:notice] = 'ログインしました。'
    artist_user_path(current_artist.id)
  end

  def after_sign_out_path_for(resource)
    flash[:notice] = 'ログアウトしました。'
    "/"
  end

  # ゲストログイン
  def new_guest
    artist = Artist.guest
    sign_in artist
    flash[:notice] = 'ゲストアーティストとしてログインしました。'
    artist_user_path(current_artist.id)
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

  # 以下、退会処理
  def artist_state
    # 入力されたemailからアカウントを１件取得
    @artist = Artist.find_by(email: params[:artist][:email])
    # アカウントを取得できなかった場合、このメソッドを終了
    return if !@artist
    # 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
    if @artist.valid_password?(params[:artist][:password]) && @artist.is_deleted
      redirect_to new_artist_registration_path
    end
  end
  # ここまで、退会処理

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
