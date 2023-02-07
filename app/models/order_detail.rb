class OrderDetail < ApplicationRecord

  # モデルの関係
  belongs_to :order
  belongs_to :item

  def subtotal
    item.price * amount
  end

end
