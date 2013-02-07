class Recommendation < RedisBase
  extend RedisScoping

  attr_reader :host_id, :episode_id, :imdb_id, :recommendation_id

  def self.by_host(host)
    filter_chain << "recommendations_for_host:#{host.id}"
    self
  end

  def self.by_episode(episode)
    self.filter_chain << "recommendations_for_episode:#{episode.id}"
    self
  end

  def episode
    has_one(Episode)
  end

  def host
    has_one(Host)
  end

  def movie
    has_one(Movie, self.imdb_id)
  end
end
