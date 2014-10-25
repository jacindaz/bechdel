FactoryGirl.define do

  factory :comment do
    # movie
    # user
    sequence(:body) { |n| "body of comment #{n} word word" }
  end

end
