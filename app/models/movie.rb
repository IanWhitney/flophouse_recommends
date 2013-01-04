class Movie < RedisBase
  attr_reader :title, :poster_uri

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
      $redis.hset "movie:#{id}", 'id', imdb_details.id
      $redis.hset "movie:#{id}", 'title', imdb_details.title
      $redis.hset "movie:#{id}", 'poster_uri', imdb_details.poster_uri
    end
    self.find(*args)
  end

  def number_of_recommendations
    $redis.get(self.id).to_i
  end

  def poster
    @poster_uri if @poster_uri.match(/http/)
  end
end
