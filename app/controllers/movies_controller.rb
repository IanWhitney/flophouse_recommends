class MoviesController < ApplicationController
  respond_to :json, :html

  def search
    @movies = MoviePresenter.find(
      RedisSearch.new('title_search', params[:title]).matches
    )
    respond_with(@movies)
  end

  def show
    @movies = MoviePresenter.find(params[:id])
    respond_with(@movies)
  end
end
