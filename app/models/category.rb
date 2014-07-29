class Category < ActiveRecord::Base
  belongs_to :movie

  validates :movie_id, presence: true, numericality: { integer: true }, uniqueness: { scope: :movie_id }
  validates :category, presence: true
end
