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
    if @movie.poster_uri
      @movie.poster_uri
    else
      "/images/nopicture.gif"
    end
  end
end
