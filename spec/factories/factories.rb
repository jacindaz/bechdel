FactoryGirl.define do

  sequence(:random_movie_rating) do |n|
    @ratings_array = (1..100).to_a.shuffle
    @ratings_array[n]
  end

  sequence(:random_year) do |n|
    @ratings_array = (1900..2014).to_a.shuffle
    @ratings_array[n]
  end

  sequence(:random_id) do |n|
    @ratings_array = (1..50).to_a.shuffle
    @ratings_array[n]
  end

  sequence(:sample_vote) do |n|
    [-1, 1].sample
  end

  sequence(:random_language) do |n|
    ["English", "French", "Spanish", "Chinese", "Swedish"].sample
  end

  factory :user do
    sequence(:username) { |n| "username #{n}" }
    provider "Github"
    location "Cambridge"
    email "jacindaz@gmail.com"
  end

  factory :movie do
    sequence(:title) {|n| "movie title #{n}"}
    year { generate(:random_year) }
    sequence(:summary) {|n| "movie summary word word word word #{n}"}
    language { generate(:random_language) }
    country_produced "France"
    bechdel_rating "passed"
    user
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

end
