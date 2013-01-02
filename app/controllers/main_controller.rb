class MainController < ApplicationController
  def index
    @hosts = Host.all
    @episodes = Episode.all.reverse[0..2]
  end
end
