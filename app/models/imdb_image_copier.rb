require 'open-uri'
class IMDBImageCopier
  def initialize(imdb_entry)
    @imdb_entry = imdb_entry
    copy_poster_to_local
  end

  def copy_poster_to_local
    if @imdb_entry.has_poster?
      File.open("public/images/#{@imdb_entry.id}.jpg", "wb") {|o|
        open(@imdb_entry.poster_uri) {|f|
          o.write(f.read)
        }
      }
    end
  end
end
