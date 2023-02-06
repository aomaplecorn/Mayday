class Item < ApplicationRecord

  # モデルの関係
  belongs_to :artist
  has_many :cart_items, dependent: :destroy
  has_many :order_details

  # グッズの画像
  has_one_attached :item_image

  # バリデーション
  validates :name, presence: true
  validates :amount, presence: true
  validates :price, presence: true

  # ジャケット写真の確認
  def get_item_image(width,height)
    unless item_image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpeg')
      item_image.attach(io: File.open(file_path),filename: 'default-image.jpeg',content_type: 'image/jpeg' 'image/png')
    end
    item_image.variant(resize_to_limit: [width, height]).processed
  end

  # 商品小計
  def subtotal
    item * amount
  end

  # Item内の検索機能
  def self.search(keyword)
    where(["name like? OR introduction like?", "%#{keyword}%", "%#{keyword}%"])
  end



end
