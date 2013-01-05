require 'csv'

@data_file = File.open("test/csv/data.csv")
recommendation_rows = CSV.table(@data_file)

@hosts = recommendation_rows.first.headers.reject {|h| h == :episode}

@hosts.each_with_index do |h,i|
  host_name = h.to_s.titleize
  host_name = "Dan McCoy" if host_name == "Dan Mccoy"

  @hosts[i] = host_name
  host_id = i + 1
  if !Host.find(host_id)
    $redis.sadd 'host_names', host_name
    $redis.sadd 'host_ids', host_id
    $redis.hset "host:#{host_id}", 'id', host_id
    $redis.hset "host:#{host_id}", 'name', host_name
  end
end

