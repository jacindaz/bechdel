class AddForeignKey < ActiveRecord::Migration
  def self.up
    add_column :cannes, :movie_id, :integer, null: false, default: 0
    remove_column :movies, :cannes_id
  end

  def self.down
    add_column :movies, :cannes_id, :integer
  end
end
