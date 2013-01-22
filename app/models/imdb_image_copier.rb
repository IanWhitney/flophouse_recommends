class IMDBImageCopier
  attr_accessor :imdb_entry, :copied_filename

  def initialize(imdb_entry)
    self.imdb_entry = imdb_entry
    self.copied_filename = "#{imdb_entry.id}.jpg"
  end

  def copy
    if imdb_entry.has_poster?
      RemoteStorage.store(file: open(imdb_entry.poster_uri), remote_file: RemoteFile.new(copied_filename))
    end
  end
end
