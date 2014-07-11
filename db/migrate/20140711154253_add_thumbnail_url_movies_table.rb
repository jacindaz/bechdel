class AddThumbnailUrlMoviesTable < ActiveRecord::Migration
  def change
    add_column :movies, :thumbnail_url, :string
  end
end
