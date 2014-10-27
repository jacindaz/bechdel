class RottenTomato < ActiveRecord::Base
  belongs_to :movie

  validates :movie_id, presence:true
  validates :rotten_tomatoes_movie_id, presence: true
end
