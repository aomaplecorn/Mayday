class HomesController < ApplicationController
  def top
  end

  require 'payjp'

  def purchase
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    @charge = Payjp::Charge.create(
      amount: 812, # 決済する値段
      # customer: current_user.id,
      card: params['payjp-token'], # フォームを送信すると作成・送信されてくるトークン
      currency: 'jpy'
    )
    binding.pry
  end


end
