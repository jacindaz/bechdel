class UpdateMoviesTable < ActiveRecord::Migration
  def up
    remove_column :movies, :rotten_tomatoes_rating
    remove_column :movies, :movie_url
    remove_column :movies, :poster_url
  end

  def down
    add_column :movies, :rotten_tomatoes_rating, :string, null: false
    add_column :movies, :movie_url, :string, null: false
    add_column :movies, :poster_url, :string, null: false
  end
end
