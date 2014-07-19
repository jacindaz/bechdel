class Category < ActiveRecord::Base
  has_many :movies

  validates :movie_id, presence: true, numericality: { integer: true }
  validates :category, presence: true
end
