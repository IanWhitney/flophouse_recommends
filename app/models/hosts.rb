class Hosts < RedisCollection
  def self.by_episode(episode)
    self.filter_chain << "hosts_for_episode:#{episode.id}"
    self
  end
end
