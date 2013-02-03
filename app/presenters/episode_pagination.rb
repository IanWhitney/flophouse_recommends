Page = Struct.new(:label, :class, :id)
class EpisodePagination < Array
  def initialize(pagination)
    if !pagination.subsequent.include?(pagination.last) && pagination.current != pagination.last
      self << Page.new("#{pagination.last.id}",'newest_episode',pagination.last.id)
    end

    pagination.subsequent.each do |episode|
      self << Page.new("#{episode.id}",nil,episode.id)
    end

    self << Page.new("#{pagination.current.id}",'current_episode',pagination.current.id)

    pagination.previous.each do |episode|
      self << Page.new("#{episode.id}",nil,episode.id)
    end

    if !pagination.previous.include?(pagination.first) && pagination.current != pagination.first
      self << Page.new("#{pagination.first.id}",'oldest_episode',pagination.first.id)
    end
    self
  end
end
