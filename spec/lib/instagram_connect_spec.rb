require 'rails_helper'

describe InstagramConnect do
  before do
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

      before do
        json = File.read(fixture_path + '/instagram/media_success.json')
        stub_request(:get, "https://api.instagram.com/v1/media/search/?access_token=#{ENV['INSTAGRAM_ACCESS_TOKEN']}&distance=#{location[:distance]*1000}&lat=#{location[:latitude]}&lng=#{location[:longitude]}")
                    .to_return(status: 200, body: json)
      end

      it 'returns list of images' do
        result = InstagramConnect::Photos.near(param)
        expect(result).to be_a Array
        expect(result.first.location.name).to be_a String
      end
    end

    context 'access token is invalid' do
      let(:location) { attributes_for :location }
      let(:param) { Location.create_with(location) }

      before do
        InstagramConnect.configure do |config|
          config.token = 'invalid-access-token'
        end
        json = File.read(fixture_path + '/instagram/media_invalid_token.json')
        stub_request(:get, "https://api.instagram.com/v1/media/search/?access_token=invalid-access-token&distance=#{location[:distance]*1000}&lat=#{location[:latitude]}&lng=#{location[:longitude]}")
                    .to_return(status: 200, body: json)
      end

      it 'returns list of images' do
        expect{InstagramConnect::Photos.near(param)}.to raise_error(APIError)
      end
    end

    context 'distance is empty' do
      let(:location) { attributes_for :location, distance: '' }
      let(:param) { Location.create_with(location) }

      before do
        json = File.read(fixture_path + '/instagram/media_success.json')
        stub_request(:get, "https://api.instagram.com/v1/media/search/?access_token=#{ENV['INSTAGRAM_ACCESS_TOKEN']}&distance=1000&lat=#{location[:latitude]}&lng=#{location[:longitude]}")
                    .to_return(status: 200, body: json)
      end

      it 'returns list of images' do
        result = InstagramConnect::Photos.near(param)
        expect(result).to be_a Array
        expect(result.first.location.name).to be_a String
      end
    end
  end
end
