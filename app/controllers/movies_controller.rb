class MoviesController < ApplicationController
  helper_method :hilight
  helper_method :chosen_rating?

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = ['G','PG','PG-13','R']
    if params[:ratings].nil?
      @movies = Movie.order params[:order]
    else
      array_ratings = params[:ratings].keys
      @chosen_ratings = array_ratings
      @movies = Movie.where(rating: array_ratings).order params[:order]
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  def hilight(column)
    if(params[:order].to_s == column)
      return 'hilite'
    else
      return nil
    end
  end

  def chosen_rating?(rating)
    chosen_ratings = params[:ratings]
    return true if chosen_ratings.nil?
    chosen_ratings.include? rating
  end
end
