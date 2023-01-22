class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

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

end
