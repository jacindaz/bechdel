class AlterTableNameBechdelinfoAgain < ActiveRecord::Migration
  def self.up
    rename_table :bechdel_info, :bechdel
  end

  def self.down
    rename_table :bechdel, :bechdel_info
  end
end
