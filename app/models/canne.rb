class Canne < ActiveRecord::Base
  belongs_to :movie

  validates :cannes_url, presence: true, numericality: { integer: true }
end
