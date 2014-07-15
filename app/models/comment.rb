class Comment < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user

  validates :parent_comment_id, numericality: { only_integer: true }
  validates :movie_id, presence: true, numericality: { only_integer: true }, uniqueness: { scope: :user_id }
  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :body, presence: true, allow_blank: false, length: {
      minimum: 5,
      maximum: 200,
      tokenizer: lambda { |str| str.scan(/\w+/) },
      too_short: "Must have at least %{count} words.",
      too_long: "Must have less than %{count} words."
    }
end
