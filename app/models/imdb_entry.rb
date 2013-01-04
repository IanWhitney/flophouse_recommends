class IMDBEntry
  attr_reader :id

  def initialize(imdb_id)
    @id = imdb_id
    url = "http://www.omdbapi.com/?i=#{id}&t="
    @response = HTTParty.get(url)
  end

  def details
    JSON.parse(@response.parsed_response)
  end

  def has_poster?
    poster_uri.match(/http/)
  end

  def poster_uri
    details["Poster"]
  end

  def title
    details["Title"]
  end
end
