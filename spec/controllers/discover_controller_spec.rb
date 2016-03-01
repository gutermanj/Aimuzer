require 'rails_helper'

RSpec.describe DiscoverController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #stream" do
    it "returns http success" do
      get :stream
      expect(response).to have_http_status(:success)
    end
  end

end
