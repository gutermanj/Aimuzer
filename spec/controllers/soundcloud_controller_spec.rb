require 'rails_helper'

RSpec.describe SoundcloudController, type: :controller do

  describe "GET #connect" do
    it "returns http success" do
      get :connect
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #connected" do
    it "returns http success" do
      get :connected
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    it "returns http success" do
      get :destroy
      expect(response).to have_http_status(:success)
    end
  end

end
