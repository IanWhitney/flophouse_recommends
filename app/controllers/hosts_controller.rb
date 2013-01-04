class HostsController < ApplicationController
  def show
    @host = Host.find(params[:id])
    @episodes = Episodes.by_host(@host).all
  end
end
