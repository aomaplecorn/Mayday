class OrderDetail < ApplicationRecord

  # モデルの関係
  belongs_to :order
  belongs_to :item, optional: true
  belongs_to :album, optional: true

  def subtotal
    item.price * amount
  end

end
