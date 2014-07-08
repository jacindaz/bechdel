class Vote < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user

  validate :movie_id, presence: true, numericality: { integer: true }
  validate :user_id, presence: true, numericality: { integer: true }
  validate :vote, presence: true, inclusion: { in: %w(pass not) }
end
