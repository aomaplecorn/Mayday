class CreateMusics < ActiveRecord::Migration[6.1]
  def change
    create_table :musics do |t|

      t.integer :artist_id
      t.integer :album_id
      t.string :name, null: false
      t.integer :track, default: 0
      t.text :index_info

      t.timestamps
    end
  end
end
