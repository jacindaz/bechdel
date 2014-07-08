class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :password
      t.string :avatar_url
      t.string :provider
      t.string :location
      t.string :email

      t.timestamps
    end
    add_index :users, [:username, :email], unique: true
  end
end
