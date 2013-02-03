class RedisSearch
  attr_reader :search_string
  attr_accessor :search_key

  def initialize(search_key,search_string)
    self.search_key = search_key
    self.search_string = search_string
    perform_search
  end

  def search_string=(raw_string)
    @search_string = raw_string.downcase.gsub(/[^\w|\s]/,'')
  end

  def perform_search
    matching_keys.each do |str|
      self.matches << $redis.get(str)
    end
  end

  def matching_keys
    if search_string.length > 2
      matched_strings = $redis.keys("#{search_key}:*#{search_string}*")
    else
      []
    end
  end

  def matches
    @matches ||= []
  end
end
