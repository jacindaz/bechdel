class MoviesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    if params[:search]
      @movies = Movie.search(params[:search]).order("title ASC")
    else
      @movies = Movie.all.order("title ASC")
    end
    @num_movies = 10
    @box_office_movies = Movie.movie_info(@num_movies)
  end

  def show
    @movie = Movie.find(params[:id])

    @user_voted = @movie.user_already_voted?(current_user, @movie.id)
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
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

end
