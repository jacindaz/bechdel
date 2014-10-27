class RottenTomatoes

  def initialize(category)
    @category = category
  end

  def self.box_office(num_movies)
    key = ENV["ROTTEN_TOMATOES_KEY"]
    top_box_office = JSON.parse(open("http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=#{key}&limit=#{num_movies}").read)
  end

  def self.top_rentals(num_movies)
    key = ENV["ROTTEN_TOMATOES_KEY"]
    JSON.parse(open("http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=#{key}&limit=#{num_movies}").read)
  end

  def self.movie_exists?(movie)
    Movie.find_by_title(movie.title).present?
  end

  def self.search_movie
    movie = Movie.find_by_title(@movie_title)
    rotten_tomatoes = Movie.rotten_tomatoes_movie_search(@movie_title)
    binding.pry
  end

  def self.pull_rotten_tomatoes_movies
  end

  def self.movie_info(movies, category)
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

      RottenTomatoes.update_database(new_movie, category, rt_movie["id"])
    end

  end

  def self.update_database(movie, category, rotten_tomatoes_id)
  #  binding.pry
    if !Movie.movie_exists?(movie)
      movie.save!
      Category.create(movie_id: movie.id, category: category)
      RottenTomato.create(rotten_tomatoes_movie_id: rotten_tomatoes_id,
                                        movie_id: movie.id)
      puts "Successfully saved: #{movie.title}"
    elsif Movie.movie_exists?(movie)
      existing_movie = Movie.find_by_title(movie.title)
      Category.where(category: category, movie_id: existing_movie.id).first_or_create
      RottenTomato.where(rotten_tomatoes_movie_id: rotten_tomatoes_id, movie_id: existing_movie.id).first_or_create
      puts "Successfully updated: #{movie.title}"
    else
      puts "Error, movie and category could not be saved."
    end
  end

end
