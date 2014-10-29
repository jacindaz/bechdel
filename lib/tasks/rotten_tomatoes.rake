require "rotten_tomatoes"

desc "Call Rotten Tomatoes API for movie information"
  namespace :rotten_tomatoes do
    task :pull_box_office_movies => :environment do
      box_office_movies_from_api = RottenTomatoes.box_office(50)
      RottenTomatoes.movie_info(box_office_movies_from_api, 'box_office')
    end

    task :pull_top_rentals_movies do
      top_rental_movies_from_api = RottenTomatoes.top_rentals(50)
      RottenTomatoes.movie_info(top_rental_movies_from_api, 'rentals')
    end

    task :pull_current_release_dvds => :environment do
      rotten_tomatoes_object = RottenTomatoes.new('current_release')
      current_release_dvds_from_api = rotten_tomatoes_object.current_release_dvds(50)
      rotten_tomatoes_object.movie_info(current_release_dvds_from_api)
    end

  end
