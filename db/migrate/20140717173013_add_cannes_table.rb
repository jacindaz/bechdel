class AddCannesTable < ActiveRecord::Migration
  def change
    create_table :cannes do |t|
      t.string :cannes_url, null: false
      t.integer :movie_id, null: false
      t.timestamps
    end
  end
end
