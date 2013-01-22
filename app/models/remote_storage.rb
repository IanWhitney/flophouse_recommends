include AWS::S3
class RemoteStorage
  def self.store(args={})
    establish_connection
    remote_file = args[:remote_file]
    S3Object.store(remote_file.file_name, args[:file], ENV['S3_BUCKET'], :access => :public_read) if !remote_file.exists?
  end
  
  def self.establish_connection
    AWS::S3::Base.establish_connection!(:access_key_id => ENV["S3_ACCESS_KEY_ID"],:secret_access_key => ENV["S3_SECRET_ACCESS_KEY"])
  end
end