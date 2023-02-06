class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|

      t.string :charge_id, null: false
      t.integer :item_id
      t.integer :album_id
      t.integer :music_id
      t.integer :order_id
      t.integer :price, null: false
      t.integer :amount

      t.timestamps
    end
  end
end
