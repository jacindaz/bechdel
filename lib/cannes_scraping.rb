class CannesScraping

  attr_reader :cannes_info

  def initialize(year)
    @cannes_info = Nokogiri::HTML(open("http://www.festival-cannes.fr/en/archives/#{year}/inCompetition.html"))
  end

  def selection_links(page)
    page = cannes_info
    movies = []
    (page.css('ul.list-movies-1').css('li').css('a')).each do |movie_link|
      movie = {}
      individual_link = movie_link.attributes["href"].value
      movie_title = movie_link.text
      movie[:title] = movie_title
      movie[:url] = individual_link
      movies << movie
    end
  end


#page.css('ul.list-movies-1').css('li').css('a')[0].attributes["href"].value

end
