class CreateAlbums < ActiveRecord::Migration[8.0]
  def change
    create_table :albums do |t|
      t.string :title
      t.string :description
      t.integer :mode

      t.timestamps
    end
  end
end
