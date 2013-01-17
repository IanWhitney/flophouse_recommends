class Episodes < RedisCollection
  def self.by_host(host)
    self.filter_chain << "episodes_for_host:#{host.id}"
    self
  end
end
