class MoviePresenter
  include Enumerable

  def self.find(id)
    self.new(Movie.find_collection(id))
  end

  def initialize(collection)
    @collection = []
    collection.each do |m|
      @collection << MovieDisplay.new(m)
    end
  end

  def each &blk
    @collection.each &blk
  end

  def method_missing(meth, *args, &block)
    @collection.send(meth, *args, &block)
  end

  def respond_to?(method)
    @collection.respond_to?(method)
  end

  def as_json(options={})
    movies = {movies: []}
    @collection.each {|m| movies[:movies] << m}
    movies
  end
end
