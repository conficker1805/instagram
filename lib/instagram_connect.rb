require 'singleton'

class InstagramConnect
  include Singleton
  attr_reader :config

  def self.configure
    yield(instance.config) if block_given?
  end

  def config
    @config ||= Configuration.instance
  end

  class Configuration
    include Singleton

    attr_accessor :token, :url, :version
  end

  class Photos
    def self.near(location)
      @connection ||= ::Faraday.new(
        url: InstagramConnect.instance.config.url,
        ssl: {
          verify: ENV['SSL_VERIFY'] == 'true'
        }
      ) do |faraday|
        faraday.request :url_encoded
        faraday.adapter Faraday.default_adapter
      end

      result = @connection.get do |req|
        req.url "/#{ InstagramConnect.instance.config.version }/media/search/"
        req.headers['Content-Type'] = 'application/json'
        req.headers['Accept'] = 'application/json'
        req.params['lat'] = location.latitude
        req.params['lng'] = location.longitude
        req.params['distance'] = location.distance * 1000
        req.params['access_token'] = InstagramConnect.instance.config.token
      end
    end
  end
end