require 'singleton'

class InstagramConnect
  include Singleton
  attr_reader :config, :connection

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

      distance = location.distance.present? ? location.distance.to_i * 1000 : 1000
      result = @connection.get do |req|
        req.url "/#{ InstagramConnect.instance.config.version }/media/search/"
        req.headers['Content-Type'] = 'application/json'
        req.headers['Accept'] = 'application/json'
        req.params['lat'] = location.latitude
        req.params['lng'] = location.longitude
        req.params['distance'] = distance
        req.params['access_token'] = InstagramConnect.instance.config.token
      end

      Mapper::InstagramMedia.new.(result)
    end
  end
end

module Mapper
  class InstagramMedia
    def call(result)
      data = JSON.parse(result.body)["data"]
      photos = data.map { |photo| InstagramPhotoEntity.new(photo)}
    end
  end
end
