class Canne < ActiveRecord::Base
  belongs_to :movie

  validates :cannes_url, presence: true, uniqueness: { scope: :movie_id }
  validates :movie_id, presence: true
end
