class Recommendation < RedisBase
  attr_reader :host_id, :episode_id, :imdb_id

  def episode
    has_one(Episode)
  end

  def host
    has_one(Host)
  end
end
