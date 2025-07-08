class AddFeaturedImageToPhotos < ActiveRecord::Migration[8.0]
  def change
    add_column :photos, :featured_image, :string
  end
end
