class MovieDisplay
  attr_accessor :movie

  def initialize(movie)
    self.movie = movie
    self
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
    "http://www.imdb.com/title/#{@movie.id}"
  end

  def badge
    nil
  end
end
