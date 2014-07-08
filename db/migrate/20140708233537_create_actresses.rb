class CreateActresses < ActiveRecord::Migration
  def change
    create_table :actresses do |t|

      t.timestamps
    end
  end
end
