class VotesController < ApplicationController

  def new
    @vote = Vote.new
  end

  def create
    @vote = Vote.new(vote_params)
    @movie = Movie.find(params[:movie_id])
    @vote.user = current_user
    @vote.movie = @movie

    if @vote.save
      @movie.save
      flash[:notice] = "Thanks for voting!"
      redirect_to movie_path(@movie)
    else
      flash.now[:notice] = "Unable to save vote."
      render :'movies/show'
    end
  end

  private
  def vote_params
    params.require(:vote).permit(:vote)
  end

end
