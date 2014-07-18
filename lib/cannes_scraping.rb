class CannesScraping

  attr_reader :cannes_info, :user_id, :year

  def initialize(year, user_id)
    @year = year
    @user_id = user_id
    @cannes_info = Nokogiri::HTML(open("http://www.festival-cannes.fr/en/archives/#{year}/inCompetition.html"))
  end

  def get_page(url)
    sleep(2)
    puts "Scraping: #{url}"
    return open(url)
  end

  def selection_links
    puts "Pulling links from #{year} Cannes Film Festival selection"
    page = cannes_info
    movies = []
    (page.xpath('//a[contains(@href, "/en/archives/ficheFilm")]')).each do |movie_link|
      movie = {}
      individual_link = movie_link.attributes["href"].value
      movie_title = movie_link.text
      movie[:title] = movie_title
      movie[:url] = "http://www.festival-cannes.fr#{individual_link}"
      movies << movie
    end
    puts "Done pulling in links for each movie."
    movies
  end

  def parse_movie_title(html_text)
    movie_title_parsed = html_text.title.split("-")[0].strip.split.map(&:capitalize)
    movie_title_parsed.each do |word|
      if word[0] == "("
        letter = word[1]
        word[1] = letter.upcase
      end
    end
    movie_title_join = movie_title_parsed.join(' ')
    movie_title_join
  end

  def movie_info(url)
    puts nil
    puts "============================================="
    puts "Gathering info for one movie: #{url}"
    page = Nokogiri::HTML(get_page("#{url}"))
    movie = {}

    movie[:title] = parse_movie_title(page)
    movie[:year] = page.xpath('//dt[contains(text(),"Year:")]').first.next_element.text.to_i
    movie[:summary] = page.css('div.synopsis-1').text.split('Synopsis')[1].strip
    movie[:language] = "Unknown"
    movie[:country_produced] = page.xpath('//dt[contains(text(), "Country:")]').first.next_element.text.strip.split(", ")[0].capitalize
    movie[:user_id] = user_id

    partial_thumbnail_url = page.xpath('//img[contains(@src, "fiche_film_header")]')
    if !partial_thumbnail_url.empty?
      complete_url = page.xpath('//img[contains(@src, "fiche_film_header")]')[0].attributes["src"].value
      movie[:thumbnail_url] = "http://www.festival-cannes.fr#{complete_url}"
    end

    puts "Done gathering, this is 1 movie's info: #{movie}"
    movie
  end

  def all_movie_info
    puts "In all movie info method, putting together url and other movie info"
    combined_information = []
    movie_links = selection_links
    puts "These are the movie links from all movie method: #{movie_links}"
    #loop over links
    movie_links.each do |movie|
      one_movie_info = movie_info(movie[:url])
      one_movie_info[:cannes_url] = movie[:url]
      combined_information << one_movie_info
    end
    combined_information
  end

  def save_cannes_movies(all_movies)
    puts nil
    puts "============================================="
    puts "Entering save Cannes movies to movies table"
    cannes_info = all_movies
    puts "This is all the cannes info: #{cannes_info}"
    cannes_info.each do |movie|
      movie_in_db = Movie.find_by_title(movie[:title])
      if movie_in_db.nil?
        binding.pry
        saved_movie = Movie.create(title: movie[:title],
                      year: movie[:year],
                      summary: movie[:summary],
                      language: movie[:language],
                      country_produced: movie[:country_produced],
                      user_id: movie[:user_id],
                      thumbnail_url: movie[:thumbnail_url])
        puts "Saved movie to db: #{Movie.all.last}"
      end
    end
  end

  def save_cannes_info(all_movies)
    puts nil
    puts "============================================="
    puts "Entering rows into Cannes table"
    cannes_info = all_movies
    cannes_info.each do |movie|
      current_movie = Movie.find_by_title(movie[:title])

      if current_movie.nil?
        binding.pry
      end

      canne_object = Canne.create(cannes_url: movie[:cannes_url], movie_id: current_movie.id)
      puts "This is the canne object url: #{canne_object.movie_id}"
      puts "============================================="
      puts nil
    end
  end

  def scrape_and_save
    all_movie_information = all_movie_info
    puts "Begin scraping"
    save_cannes_movies(all_movie_information)
    puts "Done scraping and saving movies"
    puts "=============================================", nil
    save_cannes_info(all_movie_information)
    puts "Done scraping and saving cannes info"
  end

end
