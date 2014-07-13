class AlterTableNameBechdelinfo < ActiveRecord::Migration
  def self.up
    rename_table :bechdelinfo, :bechdel_info
  end

  def self.down
    rename_table :bechdel_info, :bechdelinfo
  end
end
