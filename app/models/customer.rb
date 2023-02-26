class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  # モデルの関係
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy

  # 氏名は　空白を禁止、最低１文字〜最高５０文字
  validates :name, presence: true, length: { minimum: 1, maximum: 200 }
  # 氏名カナは 空白を禁止、最低１文字〜最高５０文字
  validates :name_kana, presence: true, length: { minimum: 1, maximum: 50 }, format: { with: /\A[ァ-ヶー－]+\z/ }
  # 郵便番号は 空白を禁止、正規表現を追加
  validates :postal_code, presence: true, format: { with: /\A\d{7}\z/ }
  # 住所は　空白を禁止
  validates :address, presence: true
  # メールアドレスは　空白を禁止、一意性を持たせる、正規表現を追加
  validates :email, presence: true, format: { with: /\A\S+@\S+\.\S+\z/ }
  # 電話番号は 空白を禁止、正規表現（ハイフンなし10桁〜11桁）
  validates :telephone_number, presence: true,  format: { with: /\A\d{10,11}\z/ }

  # 郵便番号＋住所を一括呼び出し
  def my_address
    '〒' + postal_code + ' ' + address
  end

  # ゲストログイン
  def self.guest
    find_or_create_by!(email: 'aaa@test.mayday') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.password_confirmation = customer.password
      customer.id = 1
      customer.name = 'ゲスト（一般会員）'
      customer.name_kana = 'ゲストイッパンカイイン'
      customer.postal_code = '1234567'
      customer.address = '住所'
      customer.telephone_number = '00012345678'
    end
  end

end
