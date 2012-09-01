class Recommendation < RedisBackedModel::RedisBackedModel
  
  def self.all
    all = []
    ids.each do |id|
      all << self.find(id)
    end
    all
  end
    
  def self.find(*args)
    args.flatten!
    found = []
    args.each do |id|
      attr = $redis.hgetall("#{key}:#{id}")
      found << self.new(attr)
    end
    
    found.count == 1 ? found.first : found
  end
  
  
  private
  
  def self.key
    'recommendation'
  end
  
  def self.ids
    @ids ||= $redis.smembers("#{key.pluralize}")
  end
  
end
