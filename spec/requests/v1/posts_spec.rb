require 'rails_helper'

RSpec.describe "V1::Posts", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/v1/posts/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/v1/posts/create"
      expect(response).to have_http_status(:success)
    end
  end

end
