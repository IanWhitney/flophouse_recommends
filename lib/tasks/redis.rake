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
