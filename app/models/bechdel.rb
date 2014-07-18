class Bechdel < ActiveRecord::Base
  belongs_to :movie

  validates :movie_id, presence: true, numericality: { integer: true }, uniqueness: true
  validates :passing_tests, presence: true
  validates :tests_explanation, presence: true

end
