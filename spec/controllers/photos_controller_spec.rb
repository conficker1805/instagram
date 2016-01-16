require "rails_helper"

describe PhotosController do
  describe "GET #index" do
    let(:params) { attributes_for(:location, distance: 999) }

    def do_request
      get :index, location: params
    end

    context "error" do
      it 'should be redirect and render error' do
        do_request
        expect(response).to render_template 'application/index'
        expect(flash[:alert]).not_to be_nil
      end
    end
  end
end
