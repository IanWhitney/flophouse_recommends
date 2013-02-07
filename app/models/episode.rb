class Episode < RedisBase
  extend RedisScoping

  def self.by_host(host)
    self.filter_chain << "episodes_for_host:#{host.id}"
    self
  end

  def self.all
    super.reverse
  end

  def number
    self.id
  end

  def recommendations
    has_many(Recommendation)
  end
  
  def has_recommendations?
    !hosts.empty?
  end

  def hosts
    has_many(Host)
  end

  def has_host?(host)
    self.hosts && self.hosts.include?(host)
  end
end
