class MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
    @movie_display = MovieDisplay.new(@movie)
  end
end
