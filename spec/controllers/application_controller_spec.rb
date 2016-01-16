require "rails_helper"

describe ApplicationController do
  describe "GET #index" do
    def do_request
      get :index
    end

    context "success" do
      it 'should be render successful' do
        do_request
        expect(response).to render_template :index
        expect(response.status).to eq 200
      end
    end
  end
end
