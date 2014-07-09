class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :avatar_url
      t.string :provider
      t.string :location

      t.timestamps
    end
  end
end
