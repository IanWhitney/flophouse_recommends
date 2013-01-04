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
    if @movie.poster
      AWS::S3::Base.establish_connection!(:access_key_id => ENV["S3_ACCESS_KEY_ID"],:secret_access_key => ENV["S3_SECRET_ACCESS_KEY"])
      S3Object.find("#{@movie.id}.jpg", ENV['S3_BUCKET']).url
    else
      "/images/nopicture.gif"
    end
  end
end
