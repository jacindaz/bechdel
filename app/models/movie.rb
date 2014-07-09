class Movie < ActiveRecord::Base
  has_many :actresses
  has_many :actresses, through: :actresses_movies
  has_many :votes
  has_many :comments
  belongs_to :user

  validate :title, presence: true
  validate :year, presence: true
  validate :summary, presence: true
  validate :language, presence: true
  validate :country_produced, presence: true
  validate :bechdel_rating, presence: true, inclusion: { in: %w(pass not) }
  # validate :poster_url, presence: true
  # validate :movie_url, presence: true
  validate :user_id, presence: true
end
