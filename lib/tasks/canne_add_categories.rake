require "cannes_scraping"

namespace :cannes do
  task :add_categories => :environment do
    scraper = CannesScraping.new(2014, 1)
    scraper.add_category
  end
end
