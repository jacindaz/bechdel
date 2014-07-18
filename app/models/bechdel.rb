class Bechdel < ActiveRecord::Base
  belongs_to :movie

  validates :movie_id, presence: true, numericality: { integer: true }, uniqueness: {scope: :passing_tests}
  validates :passing_tests, presence: true
  validates :tests_explanation, presence: true

  after_save :update_movie_object

  def update_movie_object
    current_movie = Movie.all.last

  end
end
