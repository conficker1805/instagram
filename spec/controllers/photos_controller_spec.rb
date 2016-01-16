require "rails_helper"

describe PhotosController do
  describe "GET #index" do
    context "error" do
      let(:params) { attributes_for(:location, distance: 999) }

      def do_request
        get :index, location: params
      end

      it 'should be redirect and render error' do
        do_request
        expect(response).to render_template 'application/index'
        expect(flash[:alert]).not_to be_nil
      end
    end

    context "successful" do
      let(:params) { attributes_for(:location) }

      before do
        WebMock.allow_net_connect!
      end

      def do_request
        get :index, location: params
      end

      it 'should be render :index with images' do
        do_request
        expect(response).to render_template :index
      end
    end
  end
end
