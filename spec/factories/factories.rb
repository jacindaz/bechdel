FactoryGirl.define do

  sequence(:random_movie_rating) do |n|
    @ratings_array = (1..100).to_a.shuffle
    @ratings_array[n]
  end

  sequence(:random_id) do |n|
    @ratings_array = (1..50).to_a.shuffle
    @ratings_array[n]
  end

  sequence(:sample_vote) do |n|
    [-1, 1].sample
  end

  factory :movie do
    sequence(:title) {|n| "movie title #{n}"}
    sequence(:year) {|n| n + 1}
    sequence(:summary) {|n| "movie summary word word word word #{n}"}
    sequence(:language) {|n| "movie language #{n}"}
    country_produced "USA"
    bechdel_rating "passed"
    # poster_url "http://www.google.com"
    # rotten_tomatoes_rating { generate(:random_movie_rating) }
    # movie_url "http://www.imgur.com/"
    user_id { generate(:random_id) }
  end

  factory :actress do
    sequence(:name) { |n| "actress name #{n}" }
    movie
    gender "female"
  end

  factory :comment do
    movie
    user
    sequence(:body) { |n| "body of comment #{n}" }
  end

  factory :vote do
    movie
    user
    vote -1
  end

  factory :user do
    sequence(:username) {|n| "filmbuff#{n}"}
    sequence(:email) {|n| "jazz#{n}@movies.com"}
    password '1234567890'
    password_confirmation '1234567890'
  end

end
