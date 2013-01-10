class MovieDisplay
  def initialize(movie)
    @movie = movie
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
