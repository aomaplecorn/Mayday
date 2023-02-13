class Order < ApplicationRecord

  # モデルの関係
  belongs_to :artist
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  # バリデーション
  validates :name, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true

  # enumの内訳 ０＝発送準備中、１＝発送済み
  enum status: { preparing_delivery: 0, delivered: 1}


end
