class BechdelInfo < ActiveRecord::Base
  belongs_to :movie

  validate :movie_id, presence: true, numericality: { integer: true }
  validate :passing_tests, presence: true
  validate :tests_explanation, presence: true

  BECHDEL_WEBSITE_HOMEPAGE = Nokogiri::HTML(open("http://bechdeltest.com/"))

  #scrapes movie show page, for description if passed or not
  def self.one_movie_bechdel_website(movie_url)
    encode_url = URI::encode("#{movie_url}")
    page = Nokogiri::HTML(open("#{encode_url}"))
    num_tests_pass = page.css('p')[0].children[0].text
    explanation = page.css('h2')[0].children[0].attributes["title"].value
    explanation[0] = ""
    explanation[-1] = ""
    title = page.css('title').children.text
    movie_title = title.split(" -")[0]
    bechdel_website = { num_tests_pass: num_tests_pass,
                        explanation: explanation, movie_title: movie_title }
  end

  #scrapes homepage of bechdeltest.com website, and creates array of movie titles
  def self.bechdel_website_titles
    page = BECHDEL_WEBSITE_HOMEPAGE
    movie_titles = []
    page.xpath('//a[contains(@id, "movie")]').each do |movie|
      movie_titles << movie.text
    end
  end

  #scrapes homepage, grabs links of movie show page
  def self.bechdel_website_movie_urls
    page = BECHDEL_WEBSITE_HOMEPAGE
    links = page.css("a")
    movie_links = []
    links.each do |link|
      if !(link.attributes["href"]).nil? && (link.attributes["href"].value.start_with?("/view"))
        partial_link = link.attributes["href"].value
        full_link = "http://bechdeltest.com#{partial_link}"
        movie_links << full_link
      end
    end
    movie_links.uniq!
    8.times do
      movie_links.pop
    end
    movie_links
  end

  def self.bechdel_titles_urls
    page = BECHDEL_WEBSITE_HOMEPAGE
    all_titles = BechdelInfo.bechdel_website_titles
    all_urls = BechdelInfo.bechdel_website_movie_urls
    titles_urls = []
    all_urls.each do |url|
      all_titles.each do |movie|
        movie_info = {}
        movie_info[:url] = url
        movie_info[:title] = movie
      end
      titles_urls << movie_info
    end
    titles_urls
  end

  def self.bechdel_movie_info
    array_of_urls = BechdelInfo.bechdel_website_movie_urls
    movies = []
    array_of_urls.each do |url|
      one_movie_hash = BechdelInfo.one_movie_bechdel_website(url)
      one_movie_hash[:url] = url
      movies << one_movie_hash
    end
    movies
  end

  def self.save_bechdel_to_db
    bechdel_info = BechdelInfo.bechdel_movie_info
    binding.pry
    bechdel_info.each do |movie|
      movie_in_db = Movie.find_by_title(movie[:movie_title])
      if !movie_in_db.nil?
        BechdelInfo.create(movie_id: movie_in_db.id,
                            bechdel_url: movie[:url],
                            passing_tests: movie[:num_tests_pass],
                            tests_explanation: movie[:explanation]
                            )
      end
    end
  end


end
