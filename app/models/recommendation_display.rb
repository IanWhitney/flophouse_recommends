class RecommendationDisplay
  def initialize(recommendation)
    @recommendation = recommendation
    self
  end

  def name
    "IMDB #{@recommendation.imdb_id}"
  end

  def image
    'comes from ?'
  end
end
