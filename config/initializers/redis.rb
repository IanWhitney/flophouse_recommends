# uri = URI.parse(ENV["REDISTOGO_URL"])
# $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
if Rails.env.production?
  uri = URI.parse(ENV["REDISTOGO_URL"])
  $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
else
  uri = URI.parse(ENV["REDISTOGO_URL"])
  $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
   #$redis = Redis.new(:host => 'localhost', :port => 6379)
   #$redis.select(1)
end
