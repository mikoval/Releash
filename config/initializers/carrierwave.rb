CarrierWave.configure do |config|
  config.fog_credentials = {
   :provider               => 'AWS', 
    :s3_access_key_id      => ENV['S3_ACCESS_KEY'], 
    :s3_secret_access_key  => ENV['S3_SECRET_KEY']
                    
  }
  config.fog_directory  = ENV["releash"]  
end