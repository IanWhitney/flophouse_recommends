require 'csv'

@data_file = File.open("test/csv/data.csv")
recommendation_rows = CSV.table(@data_file)

@hosts = Host.all

if @episode
  recommendation_rows = recommendation_rows.select {|r| r[:episode] == @episode}
end

recommendation_rows.each do |row|
  episode_id = row[:episode]
  $redis.sadd 'episode_ids', episode_id
  $redis.hset "episode:#{episode_id}", 'id', episode_id

  @hosts.each do |host|
    host_sym = host.name.downcase.gsub(/ /,"_").to_sym
    raw_recommendations = row[host_sym]
    recommendations = raw_recommendations ? raw_recommendations.split("|") : []

    if !recommendations.empty?
      $redis.sadd "episodes_for_host:#{host.id}", episode_id
      $redis.sadd "hosts_for_episode:#{episode_id}", host.id
    end
  end
end
