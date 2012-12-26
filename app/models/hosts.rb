class Hosts < RedisCollection
  def self.by_episode(episode)
    self.collection
    @filtered = @filtered.select {|h| h.in_episode?(episode)}
    self
  end
end
