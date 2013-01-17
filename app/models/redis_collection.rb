class RedisCollection
  def self.all()
    if self.filter_chain.count > 1
      intersect = $redis.sinter(self.filter_chain)
    else
      intersect = $redis.smembers(self.filter_chain)
    end

    @filter_chain = nil

    redis_backed_object = self.name.singularize.constantize
    [redis_backed_object.find(intersect)].flatten.compact
  end

  private

  def self.filter_chain
    @filter_chain ||= []
  end
end
