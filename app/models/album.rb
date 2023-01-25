class Album < ApplicationRecord

  # モデルの関係、trackが昇順に並び替える
  has_many :musics, -> { order(track: :asc) }, dependent: :destroy

  # ジャケット画像
  has_one_attached :jacket_image

  # バリデーション
  validates :name, presence: true
  validates :price, presence: true

  # ジャケット写真の確認
  def get_jacket_image(width,height)
    unless jacket_image.attached?
      file_path = Rails.root.join('app/assets/images/background_image.jpg')
      jacket_image.attach(io: File.open(file_path),filename: 'background_image.jpg',content_type: 'image/jpeg' 'image/png')
    end
    jacket_image.variant(resize_to_limit: [width, height]).processed
  end

end
