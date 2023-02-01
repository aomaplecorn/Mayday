class Order < ApplicationRecord

  # モデルの関係
  belongs_to :customer

  # バリデーション
  validates :name, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true

  # enumの内訳 ０＝入金確認、１＝発送準備中、２＝発送済み
  enum status: { payment_confirmation: 0, preparing_delivery: 1, delivered: 2}


end
