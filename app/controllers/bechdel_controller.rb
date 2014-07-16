class BechdelController < ApplicationController

  def index
    @movies_passed = Bechdel.count(:passing_tests)

 #TestResult.count(:all,:conditions=>['starttime>=?',Time.now-3600*24])
    string = "This movie passed 1 of 3 tests. "
    @passed_1 = Bechdel.count(:all, conditions: ['passing_tests = ?', string])
    @passed_2 = Bechdel.select("passing_tests = 'This movie passed 1 of 3 tests.'").count(:passing_tests)
  end

  def new
    @bechdelinfo = Bechdel.new
  end

  def create
    @bechdelinfo = Bechdel.new(bechdel_params)
    if @bechdelinfo.save
      flash[:notice] = "saved."
      redirect_to root
    else
      flash[:notice] = "not saved."
      redirect_to root
    end
  end

  private
  def bechdel_params
    params.require(:bechdel).permit(:bechdel_url, :imdb_url, :passing_tests, :tests_explanation)
  end

end
