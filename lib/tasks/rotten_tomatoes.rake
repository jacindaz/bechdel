require "rotten_tomatoes"

desc "Call Rotten Tomatoes API for movie information"
  namespace :rt do
    task :add_genres_to_db => :environment do
      movies_from_api = RottenTomatoes.box_office(50)
      RottenTomatoes.movie_info(movies_from_api, 'box_office')
    end

  end
