require 'csv'

@data_file = File.open("test/csv/data.csv")
recommendation_rows = CSV.table(@data_file,{:col_sep => "\t"})

@episodes = Episode.all

if @episode
  @episodes = [Episode.find(@episode)]
end

@episodes.each do |episode|
  data_row = recommendation_rows.detect {|r| r[:episode] == episode.id.to_i}
  if episode.hosts
    episode.hosts.each do |host|
      host_sym = host.name.downcase.gsub(/ /,"_").to_sym
      raw_recommendations = data_row[host_sym]
      recommendations = raw_recommendations ? raw_recommendations.split(",") : []

      if !recommendations.empty?
        recommendations.each_with_index do |recommendation,index|
          recommendation_number = (index + 1)
          recommendation_id = "#{episode.id}_#{host.id}_#{recommendation_number}"
          $redis.incr recommendation
          $redis.sadd 'recommendation_ids', recommendation_id
          $redis.sadd "recommendations_for_episode:#{episode.id}", recommendation_id
          $redis.sadd "recommendations_for_host:#{host.id}", recommendation_id
          $redis.hset "recommendation:#{recommendation_id}", 'recommendation_id', recommendation_id
          $redis.hset "recommendation:#{recommendation_id}", 'host_id', host.id
          $redis.hset "recommendation:#{recommendation_id}", 'episode_id', episode.id
          $redis.hset "recommendation:#{recommendation_id}", 'imdb_id', recommendation
        end
      end
    end
  end
end
