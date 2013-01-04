include AWS::S3
class RecommendationDisplay
  def initialize(recommendation)
    @recommendation = recommendation
    @movie = @recommendation.movie
    self
  end

  def name
    @movie.title
  end

  def image
    AWS::S3::Base.establish_connection!(:access_key_id => ENV["S3_ACCESS_KEY_ID"],:secret_access_key => ENV["S3_SECRET_ACCESS_KEY"])
    if S3Object.exists?("#{@movie.id}.jpg", ENV['S3_BUCKET'])
      S3Object.url_for("#{@movie.id}.jpg", ENV['S3_BUCKET'])
    else
      "/images/nopicture.gif"
    end
  end
end
