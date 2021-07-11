require 'rails_helper'

RSpec.describe "V1::Posts::Edit", type: :request do
  describe "PUT /" do
    context "ログイン時" do
      let(:user) { create(:user) }
      let(:category) { create(:category) }
      let(:auth_tokens) { sign_in({ email: user.email, password: "password" }) }

      before do
        @post = create(:post, user: user, category: category)
        @image = create(:post_image, post: @post)
        @category = create(:category)
      end

      it "投稿編集できる" do
        put "/v1/posts/#{@post.id}", headers: auth_tokens, params: {
          post: {
            title: "EDIT_TITLE",
            sub_title: "EDIT_SUB_TITLE",
            body: "EDIT_BODY",
            category_id: @category.id,
            images: [
              {
                id: @image.id,
                file: nil,
              },
              {
                id: nil,
                file: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.png')),
              }
            ]
          }
        }
        json = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(json["post"]["title"]).to eq('EDIT_TITLE')
        expect(json["post"]["sub_title"]).to eq('EDIT_SUB_TITLE')
        expect(json["post"]["body"]).to eq('EDIT_BODY')
        expect(json["post"]["category_id"]).to eq(@category.id)
        expect(json["post"]["images"].length).to eq(2)
      end
    end
  end
end
