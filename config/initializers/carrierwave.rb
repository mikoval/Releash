CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider              => 'AWS',
    :aws_access_key_id     => ENV['AKIAIOFRK67VFYY7P5UQ'],
    :aws_secret_access_key => ENV['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'],
                      # required
  }
  config.fog_directory  = ENV["releash"]                     # required
end