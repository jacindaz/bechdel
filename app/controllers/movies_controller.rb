class MoviesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    if params[:search]
      @movies = Movie.search(params[:search]).order("title ASC")
    elsif !params[:sort_by].nil?
      @movies = Movie.return_movies(15, params[:sort_by]).paginate(page: params[:page])
    else
      infinite_scroll_movies
    end
  end

  def show
    @movie = Movie.find(params[:id])
    if @movie.thumbnail_url.starts_with?("http://content8")
      @movie_poster = @movie.thumbnail_url
      @movie_poster["tmb"] = "org"
    else
      @movie_poster = @movie.thumbnail_url
    end
    @user_voted = @movie.user_already_voted?(current_user, @movie.id)
    @comment = Comment.new
    @bechdel_info = Bechdel.find_by_movie_id(params[:id])
    @cannes_info = Canne.find_by_movie_id(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.year = movie_params[:year].to_i
    @movie.user = current_user
    if @movie.save
      flash[:notice] = "Movie saved."
      redirect_to movie_path(@movie)
    else
      flash.now[:notice] = "Movie not saved."
      render :'movies/new'
    end
  end

  private
  def movie_params
    params.require(:movie).permit(:title, :year, :summary, :language, :country_produced)
  end

  def infinite_scroll_movies
    @movies = Movie.all.paginate(page: params[:page]).order(title: :asc)
    respond_to do |format|
      format.html
      format.js
    end
  end

end
