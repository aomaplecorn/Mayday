class Artist < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # マイページの背景画像と紹介画像を設定
  has_one_attached :background_image
  has_one_attached :introduction_image
  has_one_attached :profile_image

  # グループ名は　空白を禁止、最低１文字〜最高２００文字
  validates :name, presence: true, length: { minimum: 1, maximum: 200 }
  # メールアドレスは　空白を禁止、一意性を持たせる、正規表現
  validates :email, presence: true, format: { with: /\A\S+@\S+\.\S+\z/ }
  # 電話番号は 空白を禁止、正規表現（ハイフンなし10桁〜11桁）
  validates :telephone_number, presence: true,  format: { with: /\A\d{10,11}\z/ }


  def get_background_image
    unless background_image.attached?
      file_path = Rails.root.join('app/assets/images/background_image.jpg')
      background_image.attach(io: File.open(file_path),filename: 'background_image.jpg',content_type: 'image/jpeg')
    end
    background_image
  end

  def get_introduction_image(width, height)
    unless introduction_image.attached?
      file_path = Rails.root.join('app/assets/images/background_image.jpg')
    introduction_image.attach(io: File.open(file_path),filename: 'background_image.jpg',content_type: 'image/jpeg' 'image/png')
    end
    introduction_image.variant(resize_to_limit: [width, height]).processed
  end



end
