module RedisScoping
  def all()
    scoped_ids = find_scoped_ids
    clear_filter_chain
    [redis_backed_object.find(scoped_ids)].flatten.compact
  end

  #private

  def filter_chain
    @filter_chain ||= []
  end

  def clear_filter_chain
    @filter_chain = nil
  end

  def filtering?
    filter_chain.count > 1
  end

  def find_scoped_ids
    if filter_chain.empty?
      $redis.smembers("#{key}_ids")
    else
      filtering? ? $redis.sinter(filter_chain) : $redis.smembers(filter_chain)
    end
  end
  
  def redis_backed_object
    name.singularize.constantize
  end
end
