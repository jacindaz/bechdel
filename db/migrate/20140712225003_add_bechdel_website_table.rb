class AddBechdelWebsiteTable < ActiveRecord::Migration
  def change
    create_table :movieurls do |t|
      t.string :bechdel_url
      t.string :imdb_url
      t.timestamps
    end
  end
end
