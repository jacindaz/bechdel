class AddColumnsBechdelinfo < ActiveRecord::Migration
  def change
    add_column :bechdelinfo, :passing_tests, :string, null: false
    add_column :bechdelinfo, :tests_explanation, :string, null: false
  end
end
