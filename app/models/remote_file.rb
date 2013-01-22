class RemoteFile
  attr_accessor :url, :file_name

  def exists?
    S3Object.exists?(file_name, ENV['S3_BUCKET'])
  end

  def initialize(file_name)
    self.file_name = file_name
  end
  
  def url
    "http://s3.amazonaws.com/#{ENV['S3_BUCKET']}/#{file_name}"
  end
end
