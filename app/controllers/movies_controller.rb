class MoviesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    if params[:search]
      #@movies = Movie.search(params[:search]).order("title ASC")
      @movies = Movie.order(:title).where("title ILIKE ?", "#{params[:search]}%")
    elsif !params[:sort_by].nil?
      @movies = Movie.return_movies(50, params[:sort_by]).paginate(page: params[:page])
      @title = Movie.return_index_title(params[:sort_by])
    else
      @movies = Movie.paginate(page: params[:page], per_page: 12).order(title: :asc)
      @title = "All Movies"
    end

    respond_to do |format|
      format.html
      format.json { json @movies }
    end
  end

  def show
    @movie = Movie.find(params[:id])
    @user_voted = @movie.user_already_voted?(current_user, @movie.id)
    @comment = Comment.new
    @bechdel_info = Bechdel.find_by_movie_id(params[:id])
    @cannes_info = Canne.find_by_movie_id(params[:id])

    @up_votes = @movie.up_votes.floor
    @down_votes = @movie.down_votes.floor
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

end
