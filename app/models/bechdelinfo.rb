class BechdelInfo < ActiveRecord::Bas
  belongs_to :movie

  validate :movie_id, presence: true, numericality: { integer: true }
  validate :passing_tests, presence: true
  validate :tests_explanation, presence: true
end
