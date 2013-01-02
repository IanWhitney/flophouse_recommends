class EpisodesController < ApplicationController
  def index
    @episode = Episode.all.first
    redirect_to episode_url(@episode.id)
  end

  def show
    @episode = Episode.find(params[:id])
    @previous_episodes = Episode.previous(5,@episode)
    @subsequent_episodes = Episode.subsequent(5,@episode)
    @next_previous_episode = @previous_episodes.empty? ? @episode : @previous_episodes.first
    @next_subsequent_episode = @subsequent_episodes.empty? ? @episode : @subsequent_episodes.last
  end

  def find
    @episode = Episode.find(params[:id])
    if @episode
      redirect_to episode_url(@episode.id)
    else
      redirect_to root_url
    end
  end
end
