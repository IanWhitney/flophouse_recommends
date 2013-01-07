class Movie < RedisBase
  attr_reader :title, :poster_url

  def number_of_recommendations
    $redis.get(self.id).to_i
  end

  def has_poster?
    eval(@has_poster)
  end

  def poster_url
    Poster.new("#{self.id}.jpg").url if self.has_poster?
  end
end
