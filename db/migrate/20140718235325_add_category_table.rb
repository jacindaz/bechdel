class AddCategoryTable < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :movie_id, null: false
      t.string :category, null: false

      t.timestamps
    end
  end
end
