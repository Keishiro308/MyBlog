CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: 'AKIAWBJNLLOGN55GYC4V',
    aws_secret_access_key: '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',
    region: 'ap-northeast-1'
  }

  config.fog_directory  = 'myblog-s3-rails'
  config.cache_storage = :fog
end
