FactoryGirl.define do

  factory :movie do
    sequence(:title) {|n| "movie title #{n}"}
    year { (1900..2014).to_a.sample }
    sequence(:summary) {|n| "movie summary word word word word #{n}"}
    language "English"
    country_produced "United States"
    bechdel_rating "no rating"
    thumbnail_url "no-image.jpeg"
    # user
  end

end
