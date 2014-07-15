require "bechdel_scraping"

desc "This task is called by the Heroku scheduler add-on"
  namespace :bechdel do
    task :scrape => :environment do
      scraper = BechdelScraping.new
      scraper.save_bechdel_to_db
    end
  end
