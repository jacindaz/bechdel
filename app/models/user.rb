class User < ActiveRecord::Base
  has_many :movies
  has_many :votes
  has_many :comments

  validate :username, presence: true
end
