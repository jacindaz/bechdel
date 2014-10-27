class Category < ActiveRecord::Base
  has_many :movies

  validates :movie_id, presence: true, numericality: { integer: true }, uniqueness: { scope: :category }
  validates :category, presence: true

  def self.return_index_title(params_title)
    case params_title
    when "box_office"
      return "Top Box Office"
    when "rentals"
      return "Top DVD Rentals"
    when "Cannes"
      return "Selected by the Cannes Film Festival"
    end
  end

end
