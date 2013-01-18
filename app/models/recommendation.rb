class Recommendation < RedisBase
  attr_reader :host_id, :episode_id, :imdb_id, :recommendation_id

  def episode
    has_one(Episode)
  end

  def host
    has_one(Host)
  end

  def movie
    has_one(Movie, self.imdb_id)
  end
end
