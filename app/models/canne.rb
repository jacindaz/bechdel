class Canne < ActiveRecord::Base
  belongs_to :movie

  validates :cannes_url, presence: true, uniqueness: true
  validates :movie_id, presence: true
end
