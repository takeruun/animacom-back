require 'rails_helper'

RSpec.describe "V1::Users::Posts::Show", type: :request do
  describe "GET /" do
    let!(:user) { create(:user) }
    let!(:category) { create(:category) }

    shared_examples '投稿データ取得できる' do
      it do
        post = create(:post, user: user, category: category)

        get "/v1/users/posts/#{post.id}", headers: auth_tokens
        json = JSON.parse(response.body)
        
        expect(response).to have_http_status(:success)
        expect(json['post']['id']).to eq(post.id)
        expect(json['post']['user_id']).to eq(user.id)
        expect(json['post']['title']).to eq(post.title)
        expect(json['post']['sub_title']).to eq(post.sub_title)
        expect(json['post']['body']).to eq(post.body)
        expect(json['post']['category_id']).to eq(category.id)
        expect(json['post']['already_cuted']).to eq(false)
        expect(json['post']['already_faved']).to eq(false)
        expect(json['post']['already_gooded']).to eq(false)
        expect(json['post']['already_cooled']).to eq(false)
      end
    end

    context 'ログイン時' do
      let(:auth_tokens) { sign_in({ email: user.email, password: "password" }) }

      it_behaves_like '投稿データ取得できる'
    end

    context 'ログインなし' do
    end
  end
end