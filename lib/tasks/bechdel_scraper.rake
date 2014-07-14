require "bechdel_scraping"

namespace :bechdel do
  task :scrape => :environment do
    scraper = BechdelScraping.new
    scraper.save_bechdel_to_db
  end
end
