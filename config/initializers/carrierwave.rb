CarrierWave.configure do |config|
  # config.asset_host = "http://localhost:3001"

  config.storage :fog
  config.fog_credentials = {
    provider: 'AWS',
    region: 'ap-northeast-1',
    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    path_style: true,
  }
  if Rails.env.test?
    config.fog_directory  = ENV['S3_IMAGE_TEST_BUCKET']
  else
    config.fog_directory  = ENV['S3_IMAGE_BUCKET']
  end

  unless Rails.env.production?
    config.fog_credentials.merge!(
      {
        # [app -> localstack] コンテナ間の通信用に設定 ( http://localstack:4566 )
        endpoint: ENV['S3_ENDPOINT'],
      }
    )
    # endpoint がコンテナ間の通信用であるため、ホスト側から画像にアクセスするための URL ( http://localhost:4566 )
  end
end