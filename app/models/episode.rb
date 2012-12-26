class Episode < RedisBase
  def number
    self.id
  end

  def recommendations
    has_many(Recommendation)
  end

  def hosts
    has_many(Host)
  end

  def has_host?(host)
    hosts.include?(host)
  end
end
