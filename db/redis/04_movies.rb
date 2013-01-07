require 'csv'

@recommendations = Recommendation.all

if @episode
  @recommendations = Episode.find(@episode).recommendations.to_a
end

@recommendations.each do |recommendation|
  if !Movie.find(recommendation.imdb_id)
    imdb_entry = IMDBEntry.new(recommendation.imdb_id)
    $redis.sadd 'movie_ids', imdb_entry.id
    $redis.hset "movie:#{imdb_entry.id}", 'id', imdb_entry.id
    $redis.hset "movie:#{imdb_entry.id}", 'title', imdb_entry.title
    IMDBImageCopier.new(imdb_entry)
  end
end
