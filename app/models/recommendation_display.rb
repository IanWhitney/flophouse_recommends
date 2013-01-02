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
    @movie.poster
  end
end
