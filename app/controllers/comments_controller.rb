class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    current_movie = Movie.find(params[:movie_id].to_i)
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.movie = current_movie

    #binding.pry

    if @comment.save
      flash[:notice] = "Comment saved."
      redirect_to movie_path(current_movie)
    else
      flash.now[:notice] = "Unable to save comment."
      render :'movies/show'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
