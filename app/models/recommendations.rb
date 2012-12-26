class Recommendations < RedisCollection
  def self.by_host(host)
    self.collection
    @filtered = @filtered.select {|c| c.host_id == host.id}
    self
  end

  def self.by_episode(episode)
    self.collection
    @filtered = @filtered.select {|c| c.episode_id == episode.id}
    self
  end
end
