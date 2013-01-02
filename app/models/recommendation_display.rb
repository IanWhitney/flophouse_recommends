class RecommendationDisplay
  def initialize(recommendation)
    @recommendation = recommendation
    @movie = Movie.new(@recommendation)
    self
  end

  def name
    @movie.title
  end

  def image
    @movie.poster
  end
end
