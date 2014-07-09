class RemoveActressIdFromMoviesTable < ActiveRecord::Migration
  def up
    remove_column :movies, :actresses_id
  end

  def down
    add_column :movies, :actresses_id, :integer, null: false
  end
end
