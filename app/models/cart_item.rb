class CartItem < ApplicationRecord

  belongs_to :customer
  belongs_to :item

  # 小計（手数料や税計算はしない）
  def subtotal
    item.price * amount
  end

end
