require "bechdel_scraping"

desc "This task is called by the Heroku scheduler add-on"
  namespace :bechdel do
    task :scrape => :environment do
      scraper = BechdelScraping.new(2)
      scraper.save_bechdel_to_db
      scraper = BechdelScraping.new(3)
      scraper.save_bechdel_to_db
      scraper = BechdelScraping.new(4)
      scraper.save_bechdel_to_db
    end
  end
