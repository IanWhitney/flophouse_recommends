class RedisCollection
  def self.all()
    self.collection()
    all = @filtered
    @filtered = nil
    all
  end

  private

  def self.collection()
    redis_backed_object = self.name.singularize.constantize
    @filtered ||= Array.new(redis_backed_object.all)
  end
end
