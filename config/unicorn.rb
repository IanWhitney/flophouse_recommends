# taken from http://blog.railsonfire.com/2012/05/06/Unicorn-on-Heroku.html

worker_processes 3
timeout 120 # timeout 30
preload_app true

before_fork do |server, worker|
  # Replace with MongoDB or whatever
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
    Rails.logger.info('Disconnected from ActiveRecord')
  end

  # # if we want to move our redis connection out of $redis, drop connection to give new worker a new conection. i.e.:
  # if defined?(Redis)
  #   Redis.current.quit
  #   # $redis.client.disconnect
  #   Rails.logger.info('Disconnected from Redis')
  # end
  
  sleep 1
end

after_fork do |server, worker|
  # Replace with MongoDB or whatever
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
    Rails.logger.info('Connected to ActiveRecord')
  end

  # # if we want to move our redis connection out of $redis, establish a new connection for the new worker. i.e.:
  # if defined?(Redis)
  #   $redis = Redis.new(:host => 'localhost', :port => 6379)
  #   Rails.logger.info('Connected to Redis')
  # end
  
end
