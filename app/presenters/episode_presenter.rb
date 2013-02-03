class EpisodePresenter
  attr_accessor :episode, :hosts, :pagination

  def initialize(episode)
    self.episode = episode
    self.hosts = episode.hosts
    paginator = EpisodePaginator.new(episode)
    self.pagination = EpisodePagination.new(paginator)
  end

  def id
    episode.id
  end

  def has_recommendations?
    episode.has_recommendations?
  end
end
