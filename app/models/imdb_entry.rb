class IMDBEntry
  def initialize(imdb_id)
    url = "http://www.omdbapi.com/?i=#{imdb_id}&t="
    @response = HTTParty.get(url)
  end

  def details
    JSON.parse(@response.parsed_response)
  end 
end
