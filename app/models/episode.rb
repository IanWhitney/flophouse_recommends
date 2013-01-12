class Episode < RedisBase
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
