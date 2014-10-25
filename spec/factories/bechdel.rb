FactoryGirl.define do

  factory :bechdel do
    passing_tests 'This movie passed 3 of 3 tests.'
    sequence(:tests_explanation) { |n| "Sample test explanation #{n}"}
    sequence(:bechdel_url) { |n| "www.sampleurl.com/#{n}"}
    # needs a movie_id, add that in your test
  end

end
