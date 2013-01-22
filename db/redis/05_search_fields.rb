Movie.all.each do |m|
  $redis.set "title_search:#{m.title.downcase}", m.id
end