class CreatePhotos < ActiveRecord::Migration[8.0]
  def change
    create_table :photos do |t|
      t.string :title
      t.string :description
      t.integer :mode

      t.timestamps
    end
  end
end
