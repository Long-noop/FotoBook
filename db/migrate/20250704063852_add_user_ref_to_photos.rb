class AddUserRefToPhotos < ActiveRecord::Migration[8.0]
  def change
    add_reference :photos, :user, null: true, foreign_key: true
  end
end
