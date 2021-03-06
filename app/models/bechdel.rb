class Bechdel < ActiveRecord::Base
  belongs_to :movie

  validates :movie_id, presence: true, numericality: { integer: true }, uniqueness: {scope: [:passing_tests, :bechdel_url]}
  validates :passing_tests, presence: true
  validates :tests_explanation, presence: true
  validates :bechdel_url, presence: true
end
