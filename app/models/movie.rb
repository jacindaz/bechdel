require_relative 'bechdel'

class Movie < ActiveRecord::Base
  has_many :votes
  has_many :comments
  has_many :categories

  belongs_to :user
  belongs_to :bechdel
  has_one :canne
  belongs_to :rottentomato

  validates :title, presence: true, uniqueness: { scope: :year }
  validates :year, presence: true, inclusion: { in: 1900..2014 }
  validates :summary, presence: true, length: {
      minimum: 5,
      maximum: 500,
      tokenizer: lambda { |str| str.scan(/\w+/) },
      too_short: "is too short (minimum is 5 words)",
      too_long: "is too short (minimum is 500 words)"
    }
  validates :language, presence: true
  validates :country_produced, presence: true
  validates :user_id, presence: true
  validates :thumbnail_url, presence: true

  @@box_office_last_updated = nil
  @@top_rentals_last_updated = nil
  @@top_rentals_last_updated = nil

  def self.return_index_title(params_title)
    case params_title
    when 'bechdel'
      return "Movies with Bechdel Test Ratings"
    when 'box_office'
      return 'Top Box Office Movies'
    when 'rentals'
      return 'Top Rental Movies'
    when 'Cannes'
      return 'Cannes Film Festival Movies'
    end
  end

  def user_already_voted?(user_id, movie_id)
    return Vote.find_by_user_id_and_movie_id(user_id, movie_id).present?
  end

  def update_votes(pass_or_not)
    if pass_or_not == "pass"
      self.up_votes += 1
    elsif pass_or_not == "not"
      self.down_votes += 1
    end
    self.save
  end

  def self.return_bechdel_movies
    movies_with_bechdel = []
    Bechdel.all.each do |movie|
      movies_with_bechdel << Movie.find(movie.movie_id)
    end
    movies_with_bechdel
  end

  def self.return_movies(num_movies, category)
    if category == "bechdel"
      return Movie.return_bechdel_movies
    else
      categories = Category.where(category: "#{category}")
      movies = []
      categories.each do |category|
        movie = Movie.find(category.movie_id)
        movies << movie
      end
    end
    movies
  end

  def self.search(query)
    where('title ILIKE ?', "%#{query}%")
  end

  def self.top_rentals(num_movies)
    key = ENV["ROTTEN_TOMATOES_KEY"]
    JSON.parse(open("http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=#{key}&limit=#{num_movies}").read)
  end

  def self.box_office(num_movies)
    key = ENV["ROTTEN_TOMATOES_KEY"]
    top_box_office = JSON.parse(open("http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=#{key}&limit=#{num_movies}").read)
  end

  def self.rotten_tomatoes_movie_search(title)
    key = ENV["ROTTEN_TOMATOES_KEY"]
    movie_search = JSON.parse(open("http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=#{key}&q={title}").read)
  end

  def self.movie_category(num_movies, category)
    case category
    when "box_office"
      movies_hash = Movie.box_office(num_movies)
    when "rentals"
      movies_hash = Movie.top_rentals(num_movies)
    end
    movies_hash
  end

  def self.movie_info(num_movies, category)
    api_info = Movie.movie_category(num_movies, category)
    movie_info = []
    api_info["movies"].each do |rt_movie|
      new_movie = {}
      new_movie[:title] = rt_movie["title"]
      new_movie[:year] = rt_movie["year"]
      new_movie[:summary] = rt_movie["synopsis"]
      new_movie[:language] = "English"
      new_movie[:country_produced] = "United States"
      thumbnail = rt_movie["posters"]["thumbnail"]
      new_movie[:thumbnail_url] = thumbnail.sub("tmb", "org")
      movie_info << new_movie
    end
    Movie.update_database(movie_info, category)
  end

  def self.update_database(array_of_hashes, category)
    array_of_hashes.each do |hash|
      if !Movie.movie_exists?(hash)
        saved_movie = Movie.create(title: hash[:title], year: hash[:year], summary: hash[:summary],
                    language: hash[:language], country_produced: hash[:country_produced],
                    user_id: 2, thumbnail_url: hash[:thumbnail_url])
        Category.create(movie_id: saved_movie.id, category: category)
      elsif Movie.movie_exists?(hash)
        existing_movie = Movie.find_by_title(hash[:title])
        Category.where(category: category, movie_id: existing_movie.id).first_or_create
      end
    end
  end

  def self.movie_exists?(movie)
    if !Movie.find_by_title(movie[:title]).nil?
      return true
    else
      return false
    end
  end

COUNTRIES = [
  "Afghanistan",
  "Aland Islands",
  "Albania",
  "Algeria",
  "American Samoa",
  "Andorra",
  "Angola",
  "Anguilla",
  "Antarctica",
  "Antigua And Barbuda",
  "Argentina",
  "Armenia",
  "Aruba",
  "Australia",
  "Austria",
  "Azerbaijan",
  "Bahamas",
  "Bahrain",
  "Bangladesh",
  "Barbados",
  "Belarus",
  "Belgium",
  "Belize",
  "Benin",
  "Bermuda",
  "Bhutan",
  "Bolivia",
  "Bosnia and Herzegowina",
  "Botswana",
  "Bouvet Island",
  "Brazil",
  "British Indian Ocean Territory",
  "Brunei Darussalam",
  "Bulgaria",
  "Burkina Faso",
  "Burundi",
  "Cambodia",
  "Cameroon",
  "Canada",
  "Cape Verde",
  "Cayman Islands",
  "Central African Republic",
  "Chad",
  "Chile",
  "China",
  "Christmas Island",
  "Cocos (Keeling) Islands",
  "Colombia",
  "Comoros",
  "Congo",
  "Congo, the Democratic Republic of the",
  "Cook Islands",
  "Costa Rica",
  "Cote d'Ivoire",
  "Croatia",
  "Cuba",
  "Cyprus",
  "Czech Republic",
  "Denmark",
  "Djibouti",
  "Dominica",
  "Dominican Republic",
  "Ecuador",
  "Egypt",
  "El Salvador",
  "Equatorial Guinea",
  "Eritrea",
  "Estonia",
  "Ethiopia",
  "Falkland Islands (Malvinas)",
  "Faroe Islands",
  "Fiji",
  "Finland",
  "France",
  "French Guiana",
  "French Polynesia",
  "French Southern Territories",
  "Gabon",
  "Gambia",
  "Georgia",
  "Germany",
  "Ghana",
  "Gibraltar",
  "Greece",
  "Greenland",
  "Grenada",
  "Guadeloupe",
  "Guam",
  "Guatemala",
  "Guernsey",
  "Guinea",
  "Guinea-Bissau",
  "Guyana",
  "Haiti",
  "Heard and McDonald Islands",
  "Holy See (Vatican City State)",
  "Honduras",
  "Hong Kong",
  "Hungary",
  "Iceland",
  "India",
  "Indonesia",
  "Iran, Islamic Republic of",
  "Iraq",
  "Ireland",
  "Isle of Man",
  "Israel",
  "Italy",
  "Jamaica",
  "Japan",
  "Jersey",
  "Jordan",
  "Kazakhstan",
  "Kenya",
  "Kiribati",
  "Korea, Democratic People's Republic of",
  "Korea, Republic of",
  "Kuwait",
  "Kyrgyzstan",
  "Lao People's Democratic Republic",
  "Latvia",
  "Lebanon",
  "Lesotho",
  "Liberia",
  "Libyan Arab Jamahiriya",
  "Liechtenstein",
  "Lithuania",
  "Luxembourg",
  "Macao",
  "Macedonia, The Former Yugoslav Republic Of",
  "Madagascar",
  "Malawi",
  "Malaysia",
  "Maldives",
  "Mali",
  "Malta",
  "Marshall Islands",
  "Martinique",
  "Mauritania",
  "Mauritius",
  "Mayotte",
  "Mexico",
  "Micronesia, Federated States of",
  "Moldova, Republic of",
  "Monaco",
  "Mongolia",
  "Montenegro",
  "Montserrat",
  "Morocco",
  "Mozambique",
  "Myanmar",
  "Namibia",
  "Nauru",
  "Nepal",
  "Netherlands",
  "Netherlands Antilles",
  "New Caledonia",
  "New Zealand",
  "Nicaragua",
  "Niger",
  "Nigeria",
  "Niue",
  "Norfolk Island",
  "Northern Mariana Islands",
  "Norway",
  "Oman",
  "Pakistan",
  "Palau",
  "Palestinian Territory, Occupied",
  "Panama",
  "Papua New Guinea",
  "Paraguay",
  "Peru",
  "Philippines",
  "Pitcairn",
  "Poland",
  "Portugal",
  "Puerto Rico",
  "Qatar",
  "Reunion",
  "Romania",
  "Russian Federation",
  "Rwanda",
  "Saint Barthelemy",
  "Saint Helena",
  "Saint Kitts and Nevis",
  "Saint Lucia",
  "Saint Pierre and Miquelon",
  "Saint Vincent and the Grenadines",
  "Samoa",
  "San Marino",
  "Sao Tome and Principe",
  "Saudi Arabia",
  "Senegal",
  "Serbia",
  "Seychelles",
  "Sierra Leone",
  "Singapore",
  "Slovakia",
  "Slovenia",
  "Solomon Islands",
  "Somalia",
  "South Africa",
  "South Georgia and the South Sandwich Islands",
  "Spain",
  "Sri Lanka",
  "Sudan",
  "Suriname",
  "Svalbard and Jan Mayen",
  "Swaziland",
  "Sweden",
  "Switzerland",
  "Syrian Arab Republic",
  "Taiwan, Province of China",
  "Tajikistan",
  "Tanzania, United Republic of",
  "Thailand",
  "Timor-Leste",
  "Togo",
  "Tokelau",
  "Tonga",
  "Trinidad and Tobago",
  "Tunisia",
  "Turkey",
  "Turkmenistan",
  "Turks and Caicos Islands",
  "Tuvalu",
  "Uganda",
  "Ukraine",
  "United Arab Emirates",
  "United Kingdom",
  "United States",
  "United States Minor Outlying Islands",
  "Uruguay",
  "Uzbekistan",
  "Vanuatu",
  "Venezuela",
  "Viet Nam",
  "Virgin Islands, British",
  "Virgin Islands, U.S.",
  "Wallis and Futuna",
  "Western Sahara",
  "Yemen",
  "Zambia",
  "Zimbabwe"
]

end
