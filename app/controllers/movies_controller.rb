class MoviesController < ApplicationController
  def search
    search_string = params[:title].downcase.gsub(/\W/,'')
    if search_string.length > 2
      matched_titles = $redis.keys("title_search:*#{search_string}*")
      if !matched_titles.empty?
        ids = []
        matched_titles.each do |title|
          ids << $redis.get(title)
        end
        @movies = [Movie.find(ids)].flatten.compact
      end
    end
  end

  def show
    @movie = Movie.find(params[:id])
    @movie_display = MovieDisplay.new(@movie)
  end
end
