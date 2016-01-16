InstagramConnect.configure do |config|
  config.version = 'v1'
  config.url = 'https://api.instagram.com'
  config.token = ENV['INSTAGRAM_ACCESS_TOKEN']
end
