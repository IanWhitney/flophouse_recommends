class RedisBase < RedisBackedModel::RedisBackedModel
  attr_reader :id

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
      if !attr.empty?
        found << self.new(attr)
      end
    end

    if !found.empty?
      found.count == 1 ? found.first : found
    end
  end
  
  def self.find_collection(id_collection)
    [self.find(id_collection)].flatten.compact
  end

  def self.subsequent(count,instance)
    i = self.all.index(instance)
    range_start = i-count
    range_end = i
    if range_end == 0
      range_start = 0
      range_end = 0
    end

    if range_start < 0
      range_start = 0
    end
    self.all[range_start...range_end]
  end

  def self.previous(count,instance)
    i = self.all.index(instance)
    range_start = i+1
    range_end = i+count
    self.all[range_start..range_end]
  end

  def ==(o)
    o.id == self.id
  end
  alias_method :eql?, :==

  private

  def has_one(obj, id_override=nil)
    if id_override 
      obj.find(id_override)
    else
      id_property = (obj.to_s.downcase + "_id").to_sym
      obj.find(self.send(id_property))
    end
  end

  def has_many(obj)
    id_collection = $redis.smembers(obj.to_s.pluralize.downcase + "_for_" + self.class.name.downcase + ":" + self.id)
    obj.find_collection(id_collection)
  end

  def self.key
    self.name.downcase
  end

  def self.ids
    @ids ||= $redis.smembers("#{key}_ids")
  end
end

