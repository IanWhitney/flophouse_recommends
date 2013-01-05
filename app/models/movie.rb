class Movie < RedisBase
  attr_reader :title, :poster_uri

  def number_of_recommendations
    $redis.get(self.id).to_i
  end

  def poster
    @poster_uri if @poster_uri.match(/http/)
  end
end
