class Recommendations < RedisCollection
  def self.by_host(host)
    self.filter_chain << "recommendations_for_host:#{host.id}"
    self
  end

  def self.by_episode(episode)
    self.filter_chain << "recommendations_for_episode:#{episode.id}"
    self
  end
end
