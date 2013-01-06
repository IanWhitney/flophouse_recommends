class Movie < RedisBase
  attr_reader :title, :poster_uri

  def number_of_recommendations
    $redis.get(self.id).to_i
  end

  def poster_uri
    AWS::S3::Base.establish_connection!(:access_key_id => ENV["S3_ACCESS_KEY_ID"],:secret_access_key => ENV["S3_SECRET_ACCESS_KEY"])
    if S3Object.exists?("#{self.id}.jpg", ENV['S3_BUCKET'])
      S3Object.url_for("#{self.id}.jpg", ENV['S3_BUCKET'])
    end
  end
end
