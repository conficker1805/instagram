require 'rails_helper'

describe InstagramConnect do
  before do
    WebMock.allow_net_connect!

    InstagramConnect.configure do |config|
      config.token = ENV['INSTAGRAM_ACCESS_TOKEN']
      config.url = 'https://api.instagram.com'
      config.version = 'v1'
    end
  end

  describe 'InstagramPhoto#near' do
    context 'successful' do
      let(:location) { attributes_for :location }
      let(:param) { Location.create_with(location) }

      it 'returns list of images' do
        result = InstagramConnect::Photos.near(param)
        expect(result).to be_a Array
        expect(result.first.location.name).to be_a String
      end
    end
  end
end
