class AnalyticsController < ApplicationController

  def index
    @movies_passed = Bechdel.count(:passing_tests)
    # @passed_1 = Bechdel.where(passing_tests: 'This movie passed 1 of 3 tests. ').count
    # @passed_2 = Bechdel.where(passing_tests: 'This movie passed 2 of 3 tests. ').count
    # @passed_3 = Bechdel.where(passing_tests: 'This movie passed 3 of 3 tests. ').count

    @passed_1 = Bechdel.where("passing_tests like ?", "This movie passed 1%").count
    @passed_2 = Bechdel.where("passing_tests like ?", "This movie passed 2%").count
    @passed_3 = Bechdel.where("passing_tests like ?", "This movie passed 3%").count
  end

end
