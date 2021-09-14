require 'rails_helper'

RSpec.describe "V1::Users::Posts::Reactions::Couonts::Index", type: :request do
  describe "GET /" do
    let(:user) { create(:user) }
    let(:users) { create_list(:user, 21) }
    let!(:category) { create(:category) }
    let!(:posts) { create_list :post, 6, user: user, category: category }

    before do
      users.each do |user|
        create(:reaction, post_id: rand(posts.first.id..posts.last.id), user: user, kind: rand(1..4))
      end
    end

    shared_examples '本日投稿したリアクション数をが見れる' do
      it do
        if defined?(auth_tokens)
          get '/v1/users/posts/reactions/counts/', headers: auth_tokens
        else
          get '/v1/users/posts/reactions/counts/'
        end
        json = JSON.parse(response.body)

        cute_count = Reaction.where(kind: 'cute').count
        fav_count = Reaction.where(kind: 'fav').count
        good_count = Reaction.where(kind: 'good').count
        cool_count = Reaction.where(kind: 'cool').count

        expect(response).to have_http_status(:success)
        expect(json['reactions']['counts'][0]['kind']).to eq(1)
        expect(json['reactions']['counts'][0]['count']).to eq(cute_count)
        expect(json['reactions']['counts'][1]['kind']).to eq(2)
        expect(json['reactions']['counts'][1]['count']).to eq(fav_count)
        expect(json['reactions']['counts'][2]['kind']).to eq(3)
        expect(json['reactions']['counts'][2]['count']).to eq(good_count)
        expect(json['reactions']['counts'][3]['kind']).to eq(4)
        expect(json['reactions']['counts'][3]['count']).to eq(cool_count)
      end
    end

    context 'ログイン時' do
      let(:auth_tokens) { sign_in({ email: user.email, password: "password" }) }
      
      it_behaves_like '本日投稿したリアクション数をが見れる'
    end
  end
end