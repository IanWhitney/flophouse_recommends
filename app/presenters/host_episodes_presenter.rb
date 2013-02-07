class HostEpisodesPresenter
  attr_accessor :name, :episodes

  def initialize(host)
    self.name = host.name
    host.episodes.each do |episode|
      recommendations = RecommendationPresenter.new(Recommendation.by_host(host).by_episode(episode).all)
      self.episodes <<  OpenStruct.new(number: episode.number, recommendations: recommendations)
    end
  end

  def episodes
    @episodes ||= []
  end
end
