class Host < RedisBase
  attr_reader :name

  def recommendations
    has_many(Recommendation)
  end

  def episodes
    has_many(Episode)
  end

  def in_episode?(episode)
    self.episodes && episodes.include?(episode)
  end
end
