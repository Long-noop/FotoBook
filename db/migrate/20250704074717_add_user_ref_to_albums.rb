class AddUserRefToAlbums < ActiveRecord::Migration[8.0]
  def change
    add_reference :albums, :user, null: false, foreign_key: true
  end
end
