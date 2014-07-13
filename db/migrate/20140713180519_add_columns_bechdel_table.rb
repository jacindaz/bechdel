class AddColumnsBechdelTable < ActiveRecord::Migration
  def change
    add_column :movieurls, :movie_id, :integer, null: false
  end
end
