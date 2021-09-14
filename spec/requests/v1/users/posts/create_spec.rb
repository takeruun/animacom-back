require 'rails_helper'

RSpec.describe "V1::Users::Posts::Create", type: :request do
  describe "POST /" do
    context "ログイン時" do
      let!(:user) { create(:user) }
      let!(:category) { create(:category) }
      let(:auth_tokens) { sign_in({ email: user.email, password: "password" }) }

      it "投稿できる" do
        post "/v1/users/posts", headers: auth_tokens, params: {
          post: {
            title: "TITLE",
            sub_title: "SUB_TITLE",
            body: "BODY",
            category_id: category.id,
            images: [
              {
                id: '',
                file: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.png')),
              }
            ],
          }
        }
        json = JSON.parse(response.body)
        
        expect(response).to have_http_status(:success)
        expect(json["post"]["title"]).to eq('TITLE')
        expect(json["post"]["sub_title"]).to eq('SUB_TITLE')
        expect(json["post"]["body"]).to eq('BODY')
        expect(json["post"]["category_id"]).to eq(category.id)
        expect(json["post"]["images"][0]["image_path"].present?).to eq(true)
      end
    end
  end
end
