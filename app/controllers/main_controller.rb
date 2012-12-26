class MainController < ApplicationController
  def index
    @hosts = Host.all
    @episodes = Episode.all
  end
end
