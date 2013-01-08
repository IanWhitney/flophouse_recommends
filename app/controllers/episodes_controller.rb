class EpisodesController < ApplicationController
  def index
    @episode = Episode.all.first
    redirect_to episode_url(@episode.id)
  end

  def show
    @episode = Episode.find(params[:id])
    @previous_episodes = Episode.previous(3,@episode)
    @subsequent_episodes = Episode.subsequent(3,@episode)
    @next_previous_episode = @previous_episodes.empty? ? @episode : @previous_episodes.first
    @next_subsequent_episode = @subsequent_episodes.empty? ? @episode : @subsequent_episodes.last
    if !@subsequent_episodes.include?(Episode.all.first) && @episode != Episode.all.first
      @newest_episode = Episode.all.first
    end

    if !@previous_episodes.include?(Episode.all.last) && @episode != Episode.all.last
      @oldest_episode = Episode.all.last
    end
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
