class BechdelInfoController < ApplicationController

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
