class RemoveMovieIdCannesTable < ActiveRecord::Migration
  def self.up
    remove_column :cannes, :movie_id
  end

  def self.down
    add_column :cannes, :movie_id, :integer
  end
end
