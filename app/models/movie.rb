class Movie < RedisBase
  attr_reader :title, :poster_url, :has_poster

  def number_of_recommendations
    $redis.get(self.id).to_i
  end

  def has_poster?
    !@has_poster.blank?
  end

  def poster_url
    Poster.new("#{self.id}.jpg").url if self.has_poster?
  end
end
