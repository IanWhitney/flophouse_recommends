class RecommendationPresenter
  include Enumerable

  def initialize(recommendations=[])
    @collection = []
    recommendations.each do |recommendation|
      @collection << RecommendationDisplay.new(recommendation)
    end
  end

  def each &blk
    @collection.each &blk
  end
end
