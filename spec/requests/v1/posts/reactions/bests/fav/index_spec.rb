require 'rails_helper'

RSpec.describe "V1::Posts::Reactions::Bests::Fav::Index", type: :request do
  describe "GET /" do
    let(:user) { create(:user) }
    let(:users) { create_list(:user, 21) }
    let!(:category) { create(:category) }
    let!(:posts) { create_list :post, 6, user: user, category: category }

    before do
      offsets = [10, 3, 2, 5, 1]
      offsets.each_with_object(users.dup).map{|of,ar| ar.shift(of)}

      offsets.each.with_index do |offset, index|
        users.shift(offset).each do |user|
          create(:reaction, user: user, kind: 'fav', post: posts[index])
        end
      end
    end

    shared_examples 'お気に入りされている5件取得できる' do
      it do
        if defined?(auth_tokens)
          get '/v1/posts/reactions/bests/fav', headers: auth_tokens
        else
          get '/v1/posts/reactions/bests/fav'
        end
        json = JSON.parse(response.body)
        
        expect(response).to have_http_status(:success)
        expect(json['posts'].length).to eq(5)
      end
    end

    shared_examples '正しいデータが取得できる' do
      it do
        if defined?(auth_tokens)
          get '/v1/posts/reactions/bests/fav', headers: auth_tokens
        else
          get '/v1/posts/reactions/bests/fav'
        end
        json = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(json['posts'][0]['id']).to eq(posts[0].id)
        expect(json['posts'][1]['id']).to eq(posts[3].id)
        expect(json['posts'][2]['id']).to eq(posts[1].id)
        expect(json['posts'][3]['id']).to eq(posts[2].id)
        expect(json['posts'][4]['id']).to eq(posts[4].id)
      end
    end

    context 'ログイン時' do
      let(:auth_tokens) { sign_in({ email: user.email, password: "password" }) }

      it_behaves_like 'お気に入りされている5件取得できる'
      it_behaves_like '正しいデータが取得できる'
    end

    context 'ログインなし' do
      it_behaves_like 'お気に入りされている5件取得できる'
      it_behaves_like '正しいデータが取得できる'
    end
  end
end
