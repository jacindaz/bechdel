class RottenTomatoes

  def initialize(category)
    @category = category
    @key = ENV["ROTTEN_TOMATOES_KEY"]
  end

  def box_office(num_movies) JSON.parse(open("http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=#{@key}&limit=#{num_movies}").read)
  end

  def top_rentals(num_movies)  JSON.parse(open("http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=#{@key}&limit=#{num_movies}").read)
  end

  def current_release_dvds(num_movies)  JSON.parse(open("http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/current_releases.json?apikey=#{@key}&page_limit=#{num_movies}").read)
  end

  def movie_exists?(movie)
    Movie.find_by_title(movie.title).present?
  end

  def movie_info(movies)
    movies["movies"].each do |rt_movie|
      new_movie = Movie.new
      new_movie.title = rt_movie["title"]
      new_movie.year = rt_movie["year"]
      new_movie.summary = rt_movie["synopsis"]
      new_movie.language = "English"
      new_movie.country_produced = "United States"
      thumbnail = rt_movie["posters"]["thumbnail"]
      new_movie.thumbnail_url = thumbnail.sub("tmb", "org")
      new_movie.user_id = 1

      update_database(new_movie, rt_movie["id"])
    end

  end

  def update_database(movie, rotten_tomatoes_id)
    if !Movie.movie_exists?(movie)
      begin
        movie.save!
        Category.create(movie_id: movie.id, category: @category)
        RottenTomato.create(rotten_tomatoes_movie_id: rotten_tomatoes_id,
                                          movie_id: movie.id)
        puts "Successfully saved: #{movie.title}"
      rescue
        puts "====================================="
        puts 'Rescue clause, unable to save movie: ', movie.inspect
        puts "=====================================", nil
      else
        puts 'Not sure what happened here, but unable to save movie: ', movie.inspect
      end

    elsif Movie.movie_exists?(movie)
      existing_movie = Movie.find_by_title(movie.title)
      Category.where(category: @category, movie_id: existing_movie.id).first_or_create
      RottenTomato.where(rotten_tomatoes_movie_id: rotten_tomatoes_id, movie_id: existing_movie.id).first_or_create
      puts "Successfully updated: #{movie.title}"
    else
      puts "Error, movie and category could not be saved."
    end
  end

end
