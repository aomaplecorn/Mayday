class AddIntroductionToArtists < ActiveRecord::Migration[6.1]
  def change
    add_column :artists, :introduction, :text
  end
end
