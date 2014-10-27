class Analytic

  def self.movie_categories_passed_one_test(category)
    categories = Category.where(category: "#{category}")
    movies_passed = 0
    categories.each do |category|
      if (Bechdel.find_by_movie_id(category.movie_id).present?)
        movies_passed += 1
      end
    end
    movies_passed
  end

end
