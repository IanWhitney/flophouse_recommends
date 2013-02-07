class Host < RedisBase
  extend RedisScoping

  def self.by_episode(episode)
    self.filter_chain << "hosts_for_episode:#{episode.id}"
    self
  end

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
