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
    if @movie.poster_url
      @movie.poster_url
    else
      "/images/nopicture.gif"
    end
  end
end
