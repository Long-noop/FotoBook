class AddLikesCountToLikeables < ActiveRecord::Migration[8.0]
  def change
        add_column :photos, :likes_count, :integer, default: 0, null: false
        add_column :albums, :likes_count, :integer, default: 0, null: false
  end
end
