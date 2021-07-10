require 'rails_helper'

RSpec.describe "V1::Posts::Create", type: :request do
  describe "POST /" do
    context "ログイン時" do
      let!(:user) { create(:user) }
      let!(:category) { create(:category) }
      let(:auth_tokens) { sign_in({ email: user.email, password: "password" }) }

      it "投稿できる" do
        post "/v1/posts", headers: auth_tokens, params: {
          post: {
            title: "TITLE",
            sub_title: "SUB_TITLE",
            body: "BODY",
            category_id: category.id
          }
        }
        json = JSON.parse(response.body)
        
        expect(response).to have_http_status(:success)
        expect(json["post"]["title"]).to eq('TITLE')
        expect(json["post"]["sub_title"]).to eq('SUB_TITLE')
        expect(json["post"]["body"]).to eq('BODY')
        expect(json["post"]["category_id"]).to eq(category.id)
      end
    end
  end
end
