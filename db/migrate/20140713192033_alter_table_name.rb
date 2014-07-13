class AlterTableName < ActiveRecord::Migration
  def self.up
    rename_table :movieurls, :bechdelinfo
  end

  def self.down
    rename_table :bechdelinfo, :movieurls
  end
end
