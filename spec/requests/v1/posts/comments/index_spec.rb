require 'rails_helper'

RSpec.describe "V1::Posts::Comments::Index", type: :request do
  describe "GET /" do
    let!(:user) { create(:user) }
    let!(:category) { create(:category) }

    before do
      @post = create(:post, user: user, category: category)

      @comments = create_list(:comment, 3, user: user, post: @post)
    end

    shared_examples '投稿のコメントが取得できる' do
      it do
        if defined?(auth_tokens)
          get "/v1/posts/#{@post.id}/comments", headers: auth_tokens
        else
          get "/v1/posts/#{@post.id}/comments"
        end
        json = JSON.parse(response.body)
        
        expect(response).to have_http_status(:success)
        expect(json['comments'].length).to eq(@comments.count)
      end
    end

    context 'ログイン時' do
      let(:auth_tokens) { sign_in({ email: user.email, password: "password" }) }

      it_behaves_like '投稿のコメントが取得できる'
    end

    context 'ログインなし' do
      it_behaves_like '投稿のコメントが取得できる'
    end
  end
end