require 'rails_helper'

RSpec.describe "V1::Posts::DayAgo", type: :request do
  describe "GET /" do
    let!(:user) { create(:user) }
    let!(:category) { create(:category) }
    let!(:posts) { create_list :post, 1, user: user, category: category }

    before do
      posts.each do |post|
        post.update(created_at: Time.current.yesterday, updated_at: Time.current.yesterday)
      end
    end

    shared_examples '昨日投稿されたデータ取得できる' do
      it do
        if defined?(auth_tokens)
          get "/v1/posts/day_ago", headers: auth_tokens
        else
          get "/v1/posts/day_ago"
        end
        json = JSON.parse(response.body)
        
        expect(response).to have_http_status(:success)
        expect(json['posts'].length).to eq(1)
        expect(Time.current.yesterday.all_day.cover?(json['posts'][0]['created_at'])).to eq(true)
      end
    end

    shared_examples '投稿追加されても、昨日のデータ数は変わらない' do
      it do
        create(:post, user: user, category: category)
  
        if defined?(auth_tokens)
          get "/v1/posts/day_ago", headers: auth_tokens
        else
          get "/v1/posts/day_ago"
        end
        json = JSON.parse(response.body)
        
        expect(response).to have_http_status(:success)
        expect(json['posts'].length).to eq(1)
        expect(Time.current.yesterday.all_day.cover?(json['posts'][0]['created_at'])).to eq(true)
      end
    end

    context 'ログイン時' do
      let(:auth_tokens) { sign_in({ email: user.email, password: "password" }) }

      it_behaves_like '昨日投稿されたデータ取得できる'
      it_behaves_like '投稿追加されても、昨日のデータ数は変わらない'
    end

    context 'ログイン無し' do
      it_behaves_like '昨日投稿されたデータ取得できる'
      it_behaves_like '投稿追加されても、昨日のデータ数は変わらない'
    end
  end
end
