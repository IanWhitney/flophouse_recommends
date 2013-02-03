class EpisodePaginator
  attr_accessor :first, :last, :previous, :subsequent, :current

  def initialize(episode)
    self.first = Episode.first
    self.last = Episode.last
    self.previous = Episode.previous(2,episode).flatten
    self.subsequent = Episode.subsequent(2, episode).flatten
    self.current = episode
    self
  end
end
