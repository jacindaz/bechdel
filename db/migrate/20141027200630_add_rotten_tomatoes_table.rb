class AddRottenTomatoesTable < ActiveRecord::Migration
  def change
    create_table :rotten_tomatoes do |t|
      t.integer :movie_id, null: false
      t.string :rotten_tomatoes_movie_id, null: false
      t.timestamps
    end
  end
end
