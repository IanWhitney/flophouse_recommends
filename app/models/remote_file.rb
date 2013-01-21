#include AWS::S3

class RemoteFile
  attr_accessor :url

  def initialize(file_name)
    self.url = "http://s3.amazonaws.com/#{ENV['S3_BUCKET']}/#{file_name}"
  end
end
