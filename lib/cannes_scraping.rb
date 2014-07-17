class CannesScraping

  attr_reader :cannes_info, :user_id

  def initialize(year, user_id)
    @user_id = user_id
    @cannes_info = Nokogiri::HTML(open("http://www.festival-cannes.fr/en/archives/#{year}/inCompetition.html"))
  end

  def selection_links
    page = cannes_info
    movies = []
    (page.css('ul.list-movies-1').css('li').css('a')).each do |movie_link|
      movie = {}
      individual_link = movie_link.attributes["href"].value
      movie_title = movie_link.text
      movie[:title] = movie_title
      movie[:url] = "http://www.festival-cannes.fr#{individual_link}"
      movies << movie
    end
    movies
  end

  def movie_info(url)
    page = Nokogiri::HTML(open("#{url}"))
    movie = {}
    movie[:title] = page.title.split("-")[0].strip.split.map(&:capitalize).join(' ')
    movie[:year] = page.xpath('//dt[contains(text(),"Year:")]').first.next_element.text.to_i
    movie[:summary] = page.css('div.synopsis-1').text.split('Synopsis')[1].strip
    movie[:language] = "Unknown"
    movie[:country_produced] = page.xpath('//dt[contains(text(), "Country:")]').first.next_element.text.strip.split(", ")[0].capitalize
    movie[:user_id] = 2

    partial_thumbnail_url = page.xpath('//img[contains(@alt, "Film\'s poster")]')[0].attributes["src"].value
    movie[:thumbnail_url] = "http://www.festival-cannes.fr#{partial_thumbnail_url}"
    movie
  end

  def all_movie_info
    combined_information = []
    movie_links = selection_links
    #loop over links
    movie_links.each do |movie|
      one_movie_info = movie_info(movie[:url])
      one_movie_info[:cannes_url] = movie[:url]
      combined_information << one_movie_info
    end
    combined_information
  end

  def save_cannes
    puts "Entering save cannes movies to db method"
    movie_info = bechdel_movie_info
    puts "This is all the bechdel info: #{bechdel_info}"
    bechdel_info.each do |movie|
      movie_in_db = Movie.find_by_title(movie[:movie_title])
      if !movie_in_db.nil?
        Bechdel.create(movie_id: movie_in_db.id,
                            bechdel_url: movie[:url],
                            passing_tests: movie[:num_tests_pass],
                            tests_explanation: movie[:explanation]
                            )
      elsif movie_in_db.present?
        Bechdel.update(movie_id: movie_in_db.id,
                            bechdel_url: movie[:url],
                            passing_tests: movie[:num_tests_pass],
                            tests_explanation: movie[:explanation]
                            )
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
#   end
