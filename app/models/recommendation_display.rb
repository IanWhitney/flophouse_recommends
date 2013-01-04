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
      "/images/#{@movie.id}.jpg"
    else
      "/images/nopicture.gif"
    end
  end
end
