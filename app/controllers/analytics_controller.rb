class AnalyticsController < ApplicationController

  def index
    @movies_passed = Bechdel.count(:passing_tests)
    # @passed_1 = Bechdel.where(passing_tests: 'This movie passed 1 of 3 tests. ').count
    # @passed_2 = Bechdel.where(passing_tests: 'This movie passed 2 of 3 tests. ').count
    # @passed_3 = Bechdel.where(passing_tests: 'This movie passed 3 of 3 tests. ').count

    @passed_1 = Bechdel.where("passing_tests like ?", "This movie passed 1%").count
    @passed_2 = Bechdel.where("passing_tests like ?", "This movie passed 2%").count
    @passed_3 = Bechdel.where("passing_tests like ?", "This movie passed 3%").count

    @box_office = Category.where(category: 'box_office').count
    @top_rentals = Category.where(category: 'rentals').count
    @cannes = Category.where(category: 'Cannes').count

    @box_office_passed = ((Analytic.movie_categories_passed_one_test('box_office')) / @box_office.to_f) * 100
    @top_rentals_passed = ((Analytic.movie_categories_passed_one_test('rentals')) / @top_rentals.to_f) * 100
    @cannes_passed = ((Analytic.movie_categories_passed_one_test('Cannes')) / @cannes.to_f) * 100
    #binding.pry
  end

end
