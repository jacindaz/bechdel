require "cannes_scraping"

desc "This task is called by the Heroku scheduler add-on"
  namespace :cannes do
    task :scrape => :environment do
      scraper = CannesScraping.new(2014, 1)
      scraper.scrape_and_save
      scraper = CannesScraping.new(2013, 1)
      scraper.scrape_and_save
    end
  end
