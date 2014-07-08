class CreateActressesMoviesTable < ActiveRecord::Migration
  def change
    create_table :actresses_movies do |t|
      t.integer :movie_id, null: false
      t.integer :actress_id, null: false

      t.timestamps
    end
  end
end
