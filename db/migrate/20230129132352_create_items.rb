class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|

      t.integer "artist_id", null: false
      t.string "name", null: false
      t.text "introduction", null: false
      t.integer "amount", null: false
      t.integer "price", null: false
      # 販売ステータスはデフォルトをfalse（販売不可とする）
      t.boolean "is_active", default: false, null: false

      t.timestamps
    end
  end
end
