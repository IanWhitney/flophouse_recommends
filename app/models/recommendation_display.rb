class RecommendationDisplay < GenericDisplayer
  attr_accessor :recommendation

  def initialize(recommendation)
    self.recommendation = recommendation
    self.movie = recommendation.movie
  end

  def badge
    {label: movie.number_of_recommendations, url: "movie_path('#{movie.id}')"}
  end
end
