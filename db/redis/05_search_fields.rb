require 'csv'

@recommendations = @episode ? Episode.find(@episode).recommendations.to_a : Recommendation.all

@recommendations.each do |recommendation|
  m = Movie.find(recommendation.imdb_id)
  $redis.set "title_search:#{m.title.downcase}", m.id
end
