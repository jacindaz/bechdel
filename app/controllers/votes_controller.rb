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
      flash[:notice] = "Vote saved."
      redirect_to movie_path(@movie)
    else
      flash.now[:notice] = "Unable to save vote."
      render :'movies/show'
    end
  end

  def update

    @movie = Movie.find(params[:movie_id])
    @user = current_user
    @vote = Vote.find_by_user_id_and_movie_id(@user, @movie)

    if @vote.nil?
      @new_vote = Vote.new
      @new_vote.vote = params[:vote]
      @new_vote.movie = @movie
      @new_vote.user = @user
      @new_vote.save
      flash[:notice] = "You've voted!"
    else
      @vote.vote = params[:vote]
      flash[:notice] = "Vote updated!"
    end
    redirect_to movie_path(@movie)
  end

  private
  def vote_params
    params.require(:vote).permit(:vote)
  end

end
