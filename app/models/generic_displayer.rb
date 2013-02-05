class GenericDisplayer
  attr_accessor :movie

  def initialize(movie,recommendation=nil)
    self.movie = movie
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

  def badge
    nil
  end

  def url
    "http://www.imdb.com/title/#{movie.id}"
  end
end
