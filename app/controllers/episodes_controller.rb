class EpisodesController < ApplicationController
  def index
    @episode = EpisodePresenter.new(Episode.all.first)
  end

  def show
    @episode = EpisodePresenter.new(Episode.find(params[:id]))
  end

  def find
    @episode = Episode.find(params[:find_episode_id])
    if @episode
      redirect_to episode_url(@episode.id)
    else
      redirect_to root_url
    end
  end
end
