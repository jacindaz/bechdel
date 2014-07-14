class ChangeBechdelTableName < ActiveRecord::Migration
 def self.up
    rename_table :bechdel, :bechdels
  end

  def self.down
    rename_table :bechdels, :bechdel
  end
end
