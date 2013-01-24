class MoviesController < ApplicationController
  def search
    search_string = params[:title].downcase.gsub(/[^\w|\s]/,'')
    if search_string.length > 2
      matched_titles = $redis.keys("title_search:*#{search_string}*")
      if !matched_titles.empty?
        ids = []
        matched_titles.each do |title|
          ids << $redis.get(title)
        end
        @movies = MoviePresenter.find(ids)
      end
    end
  end

  def show
    @movies = MoviePresenter.find(params[:id])
  end
end
