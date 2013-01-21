class RecommendationDisplay
  attr_accessor :recommendation, :movie

  def initialize(recommendation)
    self.recommendation = recommendation
    self.movie = recommendation.movie
  end

  def name
    movie.title
  end

  def image
    if movie.poster_url
      movie.poster_url
    else
      "/images/nopicture.gif"
    end
  end

  def url
    "http://www.imdb.com/title/#{movie.id}"
  end

  def badge
    {label: movie.number_of_recommendations, url: "movie_path('#{movie.id}')"}
  end
end
