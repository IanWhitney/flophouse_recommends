class RedisCollection
  def self.all()
    ids = self.ids
    clear_filter_chain
    [redis_backed_object.find(ids)].flatten.compact
  end

  private

  def self.filter_chain
    @filter_chain ||= []
  end

  def self.clear_filter_chain
    @filter_chain = nil
  end

  def self.filtering?
    self.filter_chain.count > 1
  end

  def self.ids
    self.filtering? ? $redis.sinter(self.filter_chain) : $redis.smembers(self.filter_chain)
  end
  
  def self.redis_backed_object
    self.name.singularize.constantize
  end
end
