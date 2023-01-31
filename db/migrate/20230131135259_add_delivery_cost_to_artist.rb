class AddDeliveryCostToArtist < ActiveRecord::Migration[6.1]
  def change
    add_column :artists, :delivery_cost, :integer, default: 0
  end
end
