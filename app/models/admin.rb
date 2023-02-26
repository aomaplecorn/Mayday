class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.guest
    find_or_create_by!(email: 'aaa@test.mayday') do |admin|
      admin.password = SecureRandom.urlsafe_base64
      admin.password_confirmation = admin.password
    end
  end

end
