class CreateMoviesTable < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title, null: false
      t.integer :year, null: false
      t.text :summary, null: false
      t.string :language, null: false
      t.string :country_produced, null: false
      t.string :bechdel_rating, null: false, default: "no rating"
      t.text :poster_url, null: false
      t.string :rotten_tomatoes_rating
      t.string :movie_url, null: false
      t.integer :user_id, null: false
      t.integer :actresses_id, null: false

      t.timestamps
    end
    add_index :movies, [:title], unique: true
  end
end
