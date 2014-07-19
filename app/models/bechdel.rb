class Bechdel < ActiveRecord::Base
  belongs_to :movie

  validates :movie_id, presence: true, numericality: { integer: true }, uniqueness: {scope: :passing_tests}
  validates :passing_tests, presence: true
  validates :tests_explanation, presence: true
  validates :bechdel_url, presence: true, uniqueness: { scope: :movie_id }

  after_save :update_movie_object

end
