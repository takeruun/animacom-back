require 'rails_helper'

RSpec.describe "V1::Posts::Latest", type: :request do
  describe "GET /" do
    let!(:user) { create(:user) }
    let!(:category) { create(:category) }
    let!(:posts) { create_list :post, 1, user: user, category: category }

    shared_examples '本日投稿されたデータ取得できる' do
      it do
        if defined?(auth_tokens)
          get '/v1/posts/latest', headers: auth_tokens
        else
          get '/v1/posts/latest'
        end
        json = JSON.parse(response.body)
        
        expect(response).to have_http_status(:success)
        expect(json['posts'].length).to eq(1)
        expect(Time.current.all_day.cover?(json['posts'][0]['created_at'])).to eq(true)
      end
    end

    shared_examples '正しいデータが取得できる' do
      it do
        if defined?(auth_tokens)
          get '/v1/posts', headers: auth_tokens
        else
          get '/v1/posts'
        end
        json = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(json['posts'][0]['id']).to eq(posts.first.id)
        expect(json['posts'][0]['user_id']).to eq(user.id)
        expect(json['posts'][0]['title']).to eq(posts.first.title)
        expect(json['posts'][0]['sub_title']).to eq(posts.first.sub_title)
        expect(json['posts'][0]['body']).to eq(posts.first.body)
        expect(json['posts'][0]['category_id']).to eq(category.id)
      end
    end

    shared_examples '投稿データが増える' do
      it do
        create(:post, user: user, category: category)
  
        if defined?(auth_tokens)
          get '/v1/posts/latest', headers: auth_tokens
        else
          get '/v1/posts/latest'
        end
        json = JSON.parse(response.body)
        
        expect(response).to have_http_status(:success)
        expect(json['posts'].length).to eq(2)
      end
    end

    context 'ログイン時' do
      let(:auth_tokens) { sign_in({ email: user.email, password: "password" }) }

      it_behaves_like '正しいデータが取得できる'
      it_behaves_like '本日投稿されたデータ取得できる'
      it_behaves_like '投稿データが増える'
    end

    context 'ログインなし' do
      it_behaves_like '正しいデータが取得できる'
      it_behaves_like '本日投稿されたデータ取得できる'
      it_behaves_like '投稿データが増える'
    end
  end
end
