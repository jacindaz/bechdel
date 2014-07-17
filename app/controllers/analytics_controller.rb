class AnalyticsController < ApplicationController

  def index
    @movies_passed = Bechdel.count(:passing_tests)
    @passed_1 = Bechdel.where(passing_tests: 'This movie passed 1 of 3 tests. ').count
    @passed_2 = Bechdel.where(passing_tests: 'This movie passed 2 of 3 tests. ').count
    @passed_3 = Bechdel.where(passing_tests: 'This movie passed 3 of 3 tests. ').count

    string = "This movie passed 2 of 3 tests (although dubious)."
    @passed_2_dubious = Bechdel.where("passing_tests like ?", "#{string}%").count
  end

end
