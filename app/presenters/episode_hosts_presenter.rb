EpisodeHost = Struct.new(:name, :id, :recommendations)

class EpisodeHostsPresenter
  include Enumerable

  def initialize(episode,hosts)
    @collection = []
    hosts.each do |host|
      recommendations = RecommendationPresenter.new(Recommendation.by_host(host).by_episode(episode).all)
      @collection << EpisodeHost.new(host.name, host.id, recommendations)
    end
  end

  def each &blk
    @collection.each &blk
  end
end
