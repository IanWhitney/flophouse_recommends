class MoviesController < ApplicationController
  def search
    @movies = MoviePresenter.find(
      RedisSearch.new('title_search', params[:title]).matches
    )
  end

  def show
    @movies = MoviePresenter.find(params[:id])
  end
end
