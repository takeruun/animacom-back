require 'rails_helper'

RSpec.describe "V1::Posts", type: :request do
  describe "POST /" do
    context "未ログイン" do
      let!(:user) { create(:user) }
      let!(:category) { create(:category) }
      let!(:posts) { create_list :post, 1, user: user, category: category }

      it "投稿できる" do
        post "/v1/posts"
        json = JSON.parse(response.body)
        
        expect(response).to have_http_status(:success)
        expect(json['posts'].length).to eq(1)
      end
    end
  end
end
