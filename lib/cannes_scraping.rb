class CannesScraping

  attr_reader :homepage, :selection_2014, :selection_2013

  def initialize
    @homepage = Nokogiri::HTML(open("http://www.festival-cannes.com/"))
    @selection_2014 = Nokogiri::HTML(open("http://www.festival-cannes.fr/en/archives/2014/inCompetition.html"))
    @selection_2013 = Nokogiri::HTML(open("http://www.festival-cannes.fr/en/archives/2013/inCompetition.html"))
  end

  def selection_links(page)
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
