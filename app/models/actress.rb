class Actress < ActiveRecord::Base
  has_many :movies
  has_many :movies, through: :actresses_movies

  validate :name, presence: true
  validate :movies_id, presence: true, numericality: { only_integer: true }
  validate :gender, presence: true, inclusion: { in: %w(female male) }
end
