class Artist < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

          # グループ名は　空白を禁止、最低１文字〜最高２００文字
         validates :name, presence: true, length: { minimum: 1, maximum: 200 }
          # メールアドレスは　空白を禁止、一意性を持たせる、正規表現
         validates :email, presence: true, format: { with: /\A\S+@\S+\.\S+\z/ }
          # 電話番号は 空白を禁止、正規表現（ハイフンなし10桁〜11桁）
         validates :telephone_number, presence: true,  format: { with: /\A\d{10,11}\z/ }

end
