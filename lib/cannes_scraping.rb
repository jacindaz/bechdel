class CannesScraping

  attr_reader :cannes_info, :user_id, :year

  def initialize(year, user_id)
    @year = year
    @user_id = user_id
    @cannes_info = Nokogiri::HTML(open("http://www.festival-cannes.fr/en/archives/#{year}/inCompetition.html"))
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
    page = Nokogiri::HTML(open("#{url}"))
    movie = {}

    movie[:title] = parse_movie_title(page)
    movie[:year] = page.xpath('//dt[contains(text(),"Year:")]').first.next_element.text.to_i
    movie[:summary] = page.css('div.synopsis-1').text.split('Synopsis')[1].strip
    movie[:language] = "Unknown"
    movie[:country_produced] = page.xpath('//dt[contains(text(), "Country:")]').first.next_element.text.strip.split(", ")[0].capitalize
    movie[:user_id] = user_id

    partial_thumbnail_url = page.xpath('//img[contains(@alt, "Film\'s poster")]')
    if !partial_thumbnail_url.empty?
      complete_url = page.xpath('//img[contains(@alt, "Film\'s poster")]')[0].attributes["src"].value
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

  def save_cannes
    puts nil
    puts "============================================="
    puts "Entering save cannes movies to db method"
    cannes_info = all_movie_info
    puts "This is all the cannes info: #{cannes_info}"
    cannes_info.each do |movie|
      movie_in_db = Movie.find_by_title(movie[:title])
      if movie_in_db.nil?
        canne_object = Canne.create(cannes_url: movie[:cannes_url])
        Movie.create(title: movie[:title],
                      year: movie[:year],
                      summary: movie[:summary],
                      language: movie[:language],
                      country_produced: movie[:country_produced],
                      user_id: movie[:user_id],
                      cannes_id: canne_object.id)
      elsif !movie_in_db.nil?
        canne_object = Canne.update(cannes_url: movie[:cannes_url])
        Movie.update(title: movie[:title],
                      year: movie[:year],
                      summary: movie[:summary],
                      language: movie[:language],
                      country_produced: movie[:country_produced],
                      user_id: movie[:user_id],
                      cannes_id: canne_object.id)
      end
    end
  end

end

# create_table "cannes", force: true do |t|
#   t.string   "cannes_url", null: false
#   t.integer  "movie_id",   null: false
#   t.datetime "created_at"
#   t.datetime "updated_at"
# end


# create_table "movies", force: true do |t|
#     t.string   "title",                                      null: false
#     t.integer  "year",                                       null: false
#     t.text     "summary",                                    null: false
#     t.string   "language",                                   null: false
#     t.string   "country_produced",                           null: false
#     t.string   "bechdel_rating",   default: "no rating",     null: false
#     t.integer  "user_id",                                    null: false
#     t.datetime "created_at"
#     t.datetime "updated_at"
#     t.integer  "up_votes",         default: 0,               null: false
#     t.integer  "down_votes",       default: 0,               null: false
#     t.string   "thumbnail_url",    default: "no-image.jpeg"
#     t.integer  "cannes_id"
#   end
