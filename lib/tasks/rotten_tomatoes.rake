require "rotten_tomatoes"

desc "Call Rotten Tomatoes API for movie information"
  namespace :rt do
    task :pull_rotten_tomatoes_movies => :environment do
      box_office_movies_from_api = RottenTomatoes.box_office(50)
      RottenTomatoes.movie_info(box_office_movies_from_api, 'box_office')

      top_rental_movies_from_api = RottenTomatoes.top_rentals(50)
      RottenTomatoes.movie_info(top_rental_movies_from_api, 'rentals')
    end

  end
