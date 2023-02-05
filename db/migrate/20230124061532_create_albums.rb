class CreateAlbums < ActiveRecord::Migration[6.1]
  def change
    create_table :albums do |t|

      t.string :name, null: false
      t.integer :price, null: false
      t.boolean :released, default: false
      t.integer :artist_id


      t.timestamps
    end
  end
end
