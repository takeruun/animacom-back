require 'rails_helper'

RSpec.describe "V1::Posts::Reactions::Create", type: :request do
  describe "POST /" do
    context "ログイン時" do
      let!(:user) { create(:user) }
      let!(:category) { create(:category) }
      let(:auth_tokens) { sign_in({ email: user.email, password: "password" }) }

      before do
        @post = create(:post, user: user, category: category)
      end
      
      it '「かわいい」できる' do
        post "/v1/posts/reactions/#{@post.id}", headers: auth_tokens,
          params: {
            reaction: {
              kind: 1
            }
          }

        json = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
      end
      
      it '「お気に入り」できる' do
        post "/v1/posts/reactions/#{@post.id}", headers: auth_tokens,
          params: {
            reaction: {
              kind: 2
            }
          }

        json = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
      end

      it '「いいね」できる' do
        post "/v1/posts/reactions/#{@post.id}", headers: auth_tokens,
          params: {
            reaction: {
              kind: 3
            }
          }

        json = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
      end

      it '「かっこいい」できる' do
        post "/v1/posts/reactions/#{@post.id}", headers: auth_tokens,
          params: {
            reaction: {
              kind: 4
            }
          }

        json = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
      end
    end
  end
end
