class RedisBase < RedisBackedModel::RedisBackedModel
  attr_reader :id

  def self.all
    all = RedisArray.new
    ids.each do |id|
      all << self.find(id)
    end
    all
  end

  def self.find(*args)
    args.flatten!
    found = RedisArray.new
    args.each do |id|
      attr = $redis.hgetall("#{key}:#{id}")
      found << self.new(attr)
    end

    found.count == 1 ? found.first : found
  end

  private

  def has_one(obj)
    id_property = (obj.to_s.downcase + "_id").to_sym
    obj.find(self.send(id_property))
  end

  def has_many(obj)
    id_collection = $redis.smembers(obj.to_s.pluralize.downcase + "_for_" + self.class.name.downcase + ":" + self.id)
    obj.find(id_collection)
  end

  def self.key
    self.name.downcase
  end

  def self.ids
    @ids ||= $redis.smembers("#{key}_ids")
  end
end

