class Episodes < RedisCollection
  def self.by_host(host)
    self.collection
    @filtered = @filtered.select {|e| e.has_host?(host)}
    self
  end
end
