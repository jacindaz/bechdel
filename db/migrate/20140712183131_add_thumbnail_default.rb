class AddThumbnailDefault < ActiveRecord::Migration
  def change
    change_column :movies, :thumbnail_url, :string, default: "no-image.jpeg"
  end
end
