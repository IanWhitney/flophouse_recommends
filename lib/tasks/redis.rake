include AWS::S3

namespace :redis do
  task :add, [:episode] => [:environment] do |t,args|
    Dir[File.join(Rails.root, 'db', 'redis', '*.rb')].sort.each do |fixture|
      @episode = args[:episode].to_i
      load fixture 
      puts "Loaded #{fixture}"
    end
  end

  task :populate, [:step] => [:environment] do |t, args|
    if args[:step]
      Dir[File.join(Rails.root, 'db', 'redis', "#{args[:step]}*.rb")].sort.each do |fixture|
        load fixture
        puts "Loaded #{fixture}"
      end
    else
      $redis.flushall
      Dir[File.join(Rails.root, 'db', 'redis', '*.rb')].sort.each do |fixture| 
        load fixture 
        puts "Loaded #{fixture}"
      end
    end
  end
end

namespace :movie do
  task :new_poster, [:id, :url] => [:environment] do |t,args|
    id = args[:id]
    url = args[:url]
    AWS::S3::Base.establish_connection!(:access_key_id => ENV["S3_ACCESS_KEY_ID"],:secret_access_key => ENV["S3_SECRET_ACCESS_KEY"])
  	S3Object.store("#{id.to_s}.jpg", open(url), ENV['S3_BUCKET'], :access => :public_read)
  	$redis.hset("movie:#{id.to_s}","has_poster",true)
  end
end
  	
