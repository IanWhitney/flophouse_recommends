class Movie
  attr_reader :title, :poster

  def initialize(recommendation)
    @recommendation = recommendation
    properties = get_properties
  end 

  def get_properties()
    imdb_details = IMDBEntry.new(@recommendation.imdb_id).details
    @title = imdb_details["Title"]
    @poster = imdb_details["Poster"]
  end
end
