class AddCannesForeignKey < ActiveRecord::Migration
  def change
    add_column :movies, :cannes_id, :integer, default: nil
  end
end
