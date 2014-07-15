FactoryGirl.define do

  sequence(:random_movie_year) do |n|
    @year_array = (1900..2014).to_a.shuffle
    @year_array[n]
  end

  factory :movie do
    #sequence(:title) {|n| "movie title #{n}"}
    title { generate() }
    year { generate(:random_movie_year)}
    sequence(:summary) {|n| "movie summary word word word word #{n}"}
    language "English"
    country_produced "United States"
    bechdel_rating "no rating"
    thumbnail_url "no-image.jpeg"
    user
  end

  factory :comment do
    movie
    user
    sequence(:body) { |n| "body of comment #{n} word word" }
  end

  factory :vote do
    movie
    user
    vote -1
  end

end
