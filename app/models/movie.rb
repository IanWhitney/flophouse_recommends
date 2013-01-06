class Movie < RedisBase
  attr_reader :title, :poster_url

  def number_of_recommendations
    $redis.get(self.id).to_i
  end

  def poster_url
    Poster.new("#{self.id}.jpg").url
  end
end
