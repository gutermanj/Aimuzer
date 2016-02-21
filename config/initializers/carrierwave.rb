CarrierWave.configure do |config|
  config.root = Rails.root.join('tmp') # adding these...
  config.cache_dir = 'carrierwave' # ...two lines



  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => 'AKIAILUQBOMOARKL5FIQ',                        # required
    :aws_secret_access_key  => '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',                     # required
    # :region                 => 'eu-west-1',                  # optional, defaults to 'us-east-1'
     :host                   => 's3.amazonaws.com',             # optional, defaults to nil
    # :endpoint               => 'https://s3.example.com:8080' # optional, defaults to nil
  }
  config.fog_directory  = '/aimuzer/'                             # required
  config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end
