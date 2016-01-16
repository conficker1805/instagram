require 'rails_helper'

describe Location, type: :model do
  describe 'validations' do
    it { should validate_presence_of :latitude }
    it { should validate_presence_of :longitude }
    it { should validate_numericality_of(:latitude).is_less_than_or_equal_to(90.0) }
    it { should validate_numericality_of(:latitude).is_greater_than_or_equal_to(-90.0) }
    it { should validate_numericality_of(:longitude).is_less_than_or_equal_to(180.0) }
    it { should validate_numericality_of(:longitude).is_greater_than_or_equal_to(-180.0) }
    it { should validate_numericality_of(:distance).is_greater_than_or_equal_to(1) }
    it { should validate_numericality_of(:distance).is_less_than_or_equal_to(5) }
  end

  describe "#create_with" do
    let(:params) { {latitude: 50, longitude: 50} }

    it "returns location object" do
      expect(Location.create_with(params).latitude).to eq 50
    end
  end
end
