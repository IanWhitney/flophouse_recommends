class EpisodePresenter
  attr_accessor :episode, :hosts, :pagination

  def initialize(episode)
    self.episode = episode
    self.hosts = EpisodeHostsPresenter.new(episode,episode.hosts)
    paginate
  end

  def paginate
    self.pagination = EpisodePagination.new(EpisodePaginator.new(episode))
  end

  def id
    episode.id
  end

  def has_recommendations?
    episode.has_recommendations?
  end
end
