class Movie < RedisBase
  attr_reader :title, :poster

  def self.find(*args)
    movie = super(*args)
    if !movie
      populate_redis_from_movie_service(*args)
    else
      movie
    end
  end

  def self.populate_redis_from_movie_service(*args)
    args.flatten.each do |id|
      imdb_details = IMDBEntry.new(id).details
      $redis.hset "movie:#{id}", 'id', id
      $redis.hset "movie:#{id}", 'title', imdb_details["Title"]
      $redis.hset "movie:#{id}", 'poster', imdb_details["Poster"]
    end
    self.find(*args)
  end

  def number_of_recommendations
    $redis.get(self.id).to_i
  end

  def poster
    @poster if @poster.match(/http/)
  end
end
