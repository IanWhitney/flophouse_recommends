include AWS::S3
class IMDBImageCopier
  def initialize(imdb_entry)
    @imdb_entry = imdb_entry
    copy_poster_to_s3
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

  def copy_poster_to_s3
    AWS::S3::Base.establish_connection!(:access_key_id => ENV["S3_ACCESS_KEY_ID"],:secret_access_key => ENV["S3_SECRET_ACCESS_KEY"])
    image_name = "#{@imdb_entry.id}.jpg"

    if @imdb_entry.has_poster? && !S3Object.exists?(image_name, ENV['S3_BUCKET'])
      S3Object.store("#{@imdb_entry.id}.jpg", open(@imdb_entry.poster_uri), ENV['S3_BUCKET'])
    end
  end
end