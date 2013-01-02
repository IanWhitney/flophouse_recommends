class MainController < ApplicationController
  def index
    @episode = Episode.all.reverse[0]
  end

  def show
    @episode = Episode.find(params[:id])
  end
end
