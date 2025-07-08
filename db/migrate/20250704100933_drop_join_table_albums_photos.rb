class DropJoinTableAlbumsPhotos < ActiveRecord::Migration[8.0]
  def change
    drop_table :albums_photos
  end
end
