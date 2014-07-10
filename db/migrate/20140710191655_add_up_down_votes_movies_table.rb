class AddUpDownVotesMoviesTable < ActiveRecord::Migration
  def change
    add_column :movies, :up_votes, :integer, default: 0, null: false
    add_column :movies, :down_votes, :integer, default: 0, null: false
  end
end
