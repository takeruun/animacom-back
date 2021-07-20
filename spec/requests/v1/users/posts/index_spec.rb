require 'rails_helper'

RSpec.describe "V1::Users::Posts::Index", type: :request do
  describe "GET /" do
    let!(:user) { create(:user) }
    let!(:category) { create(:category) }
    let!(:posts) { create_list :post, 1, user: user, category: category }
    
    shared_examples '全投稿データ取得できる' do
      it do
        get '/v1/users/posts', headers: auth_tokens
        json = JSON.parse(response.body)
        
        expect(response).to have_http_status(:success)
        expect(json['posts'].length).to eq(1)
      end
    end

    shared_examples '正しいデータが取得できる' do
      it do
        get '/v1/users/posts', headers: auth_tokens
        json = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(json['posts'][0]['id']).to eq(posts.first.id)
        expect(json['posts'][0]['user_id']).to eq(user.id)
        expect(json['posts'][0]['title']).to eq(posts.first.title)
        expect(json['posts'][0]['sub_title']).to eq(posts.first.sub_title)
        expect(json['posts'][0]['body']).to eq(posts.first.body)
        expect(json['posts'][0]['category_id']).to eq(category.id)
        expect(json['posts'][0]['already_cuted']).to eq(false)
        expect(json['posts'][0]['already_faved']).to eq(false)
        expect(json['posts'][0]['already_gooded']).to eq(false)
        expect(json['posts'][0]['already_cooled']).to eq(false)
      end
    end

    context 'ログイン時' do
      let(:auth_tokens) { sign_in({ email: user.email, password: "password" }) }

      it_behaves_like '全投稿データ取得できる'
      it_behaves_like '正しいデータが取得できる'
    end

    context 'ログインなし' do
    end
  end
end
