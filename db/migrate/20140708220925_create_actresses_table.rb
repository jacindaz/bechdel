class CreateActressesTable < ActiveRecord::Migration
  def change
    create_table :actresses do |t|
      t.string :name, null: false
      t.integer :movies_id, null: false
      t.string :gender, null: false

      t.timestamps
    end
  end
end
