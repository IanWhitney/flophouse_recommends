class EpisodesController < ApplicationController
  def index
    @episode = Episode.all.first
    redirect_to episode_url(@episode.id)
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
