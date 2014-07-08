class CreateVotesTable < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :movie_id, null: false
      t.integer :user_id, null: false
      t.integer :vote, null: false

      t.timestamps
    end
  end
end
