class Comment < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user

  validate :parent_comment_id, numericality: { only_integer: true }
  validate :movie_id, presence: true, numericality: { only_integer: true }, uniqueness: { scope: :user_id }
  validate :user_id, presence: true, numericality: { only_integer: true }
  validate :body, presence: true
end
