require 'csv'

@data_file = File.open("test/csv/data.csv")
recommendation_rows = CSV.table(@data_file)

recommendation_rows = recommendation_rows.select {|r| r[:episode] == @episode_to_delete}

@hosts = Host.all

recommendation_rows.each do |row|
  puts row.inspect
  episode_id = row[:episode]
  $redis.srem 'episode_ids', episode_id
  $redis.del "episode:#{episode_id}"

  @hosts.each do |host|
    host_sym = host.name.downcase.gsub(/ /,"_").to_sym
    raw_recommendations = row[host_sym]
    recommendations = raw_recommendations ? raw_recommendations.split(",") : []
    if !recommendations.empty?
      $redis.srem "episodes_for_host:#{host.id}", episode_id
      $redis.srem "hosts_for_episode:#{episode_id}", host.id

      recommendations.each_with_index do |recommendation,index|
        movie_id = recommendation
        movie = Movie.find(movie_id)
        recommendation_number = (index + 1)
        recommendation_id = "#{@episode_to_delete}_#{host.id}_#{recommendation_number}"
        $redis.decr recommendation
        $redis.srem 'recommendation_ids', recommendation_id
        $redis.srem "recommendations_for_episode:#{@episode_to_delete}", recommendation_id
        $redis.srem "recommendations_for_host:#{host.id}", recommendation_id
        $redis.srem "recommendations_for_movie:#{movie_id}", recommendation_id
        $redis.del "recommendation:#{recommendation_id}"
        $redis.srem 'movie_ids', recommendation
        if movie.number_of_recommendations == 0
          $redis.del "title_search:#{movie.title.downcase}"
        end
        $redis.del "movie:#{movie.id}"
      end
    end
  end
end
