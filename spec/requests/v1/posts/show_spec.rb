require 'rails_helper'

RSpec.describe "V1::Posts::Show", type: :request do
  describe "GET /" do
    let!(:user) { create(:user) }
    let!(:category) { create(:category) }

    shared_examples '投稿データ取得できる' do
      it do
        post = create(:post, user: user, category: category)

        is_login = defined?(auth_tokens)
        if is_login
          get "/v1/posts/#{post.id}", headers: auth_tokens
        else
          get "/v1/posts/#{post.id}"
        end
        json = JSON.parse(response.body)
        
        expect(response).to have_http_status(:success)
        expect(json['post']['id']).to eq(post.id)
        expect(json['post']['user_id']).to eq(user.id)
        expect(json['post']['title']).to eq(post.title)
        expect(json['post']['sub_title']).to eq(post.sub_title)
        expect(json['post']['body']).to eq(post.body)
        expect(json['post']['category_id']).to eq(category.id)
      end
    end

    context 'ログイン時' do
      let(:auth_tokens) { sign_in({ email: user.email, password: "password" }) }

      it_behaves_like '投稿データ取得できる'
    end

    context 'ログインなし' do
      it_behaves_like '投稿データ取得できる'
    end
  end
end