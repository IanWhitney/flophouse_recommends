include AWS::S3

class RemoteFile
  attr_reader :url

  def initialize(file_name)
    AWS::S3::Base.establish_connection!(:access_key_id => ENV["S3_ACCESS_KEY_ID"],:secret_access_key => ENV["S3_SECRET_ACCESS_KEY"])

    if S3Object.exists?(file_name, ENV['S3_BUCKET'])
      @url = S3Object.url_for(file_name, ENV['S3_BUCKET'])
    end
  end
end