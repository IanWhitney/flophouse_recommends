class IMDBEntry
  attr_accessor :id, :response

  def initialize(imdb_id)
    self.id = imdb_id
    url = "http://omdbapi.com/?apikey=#{ENV["OMDBAPI_KEY"]}&i=#{self.id}"
    self.response = HTTParty.get(url)
  end

  def details
    response.parsed_response
  end

  def has_poster?
    (poster_uri && poster_uri.match(/http/)) ? true : false
  end

  def poster_uri
    details["Poster"]
  end

  def title
    details["Title"]
  end
end
