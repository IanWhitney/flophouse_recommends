require 'csv'

@data_file = File.open("test/csv/data.csv")
@hosts = ["Dan","Stuart","Elliot","Guest"]
@hosts.each_with_index do |h,i|
  host_id = i + 1
  $redis.sadd 'host_names', h
  $redis.sadd 'host_ids', host_id
  $redis.set "id_for_host_name:#{h}", host_id
  $redis.hset "host:#{host_id}", 'id', host_id
  $redis.hset "host:#{host_id}", 'name', h
end

recommendation_rows = CSV.table(@data_file)

recommendation_rows.each do |row|
  episode_id = row[:episode]
  $redis.sadd 'episode_ids', episode_id
  $redis.hset "episode:#{episode_id}", 'id', episode_id
  @hosts.each do |host|
    host_id = $redis.get "id_for_host_name:#{host}"
    raw_recommendations = row[host.downcase.to_sym]
    recommendations = raw_recommendations ? raw_recommendations.split("|") : []

    if !recommendations.empty?
      $redis.sadd "episodes_for_host:#{host_id}", episode_id
      $redis.sadd "hosts_for_episode:#{episode_id}", host_id
      recommendations.each_with_index do |recommendation,index|
        recommendation_number = (index + 1)
        recommendation_id = "#{episode_id}_#{host_id}_#{recommendation_number}"
        $redis.incr recommendation
        $redis.sadd 'recommendation_ids', recommendation_id
        $redis.sadd "recommendations_for_episode:#{episode_id}", recommendation_id
        $redis.sadd "recommendations_for_host:#{host_id}", recommendation_id
        $redis.hset "recommendation:#{recommendation_id}", 'recommendation_id', recommendation_id
        $redis.hset "recommendation:#{recommendation_id}", 'host_id', host_id
        $redis.hset "recommendation:#{recommendation_id}", 'episode_id', episode_id
        $redis.hset "recommendation:#{recommendation_id}", 'imdb_id', recommendation
        imdb_entry = IMDBEntry.new(recommendation)
        $redis.sadd 'movie_ids', imdb_entry.id
        $redis.hset "movie:#{imdb_entry.id}", 'id', imdb_entry.id
        $redis.hset "movie:#{imdb_entry.id}", 'title', imdb_entry.title
        $redis.hset "movie:#{imdb_entry.id}", 'poster_uri', imdb_entry.poster_uri
        IMDBImageCopier.new(imdb_entry)
      end
    end
  end
end
