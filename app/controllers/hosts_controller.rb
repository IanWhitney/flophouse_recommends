class HostsController < ApplicationController
  def show
    @host = HostEpisodesPresenter.new(Host.find(params[:id]))
  end
end
