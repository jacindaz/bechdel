FactoryGirl.define do

  factory :user do
    sequence(:username) {|n| "filmbuff#{n}"}
    sequence(:email) {|n| "jazz#{n}@movies.com"}
    password '1234567890'
    password_confirmation '1234567890'
  end

end
