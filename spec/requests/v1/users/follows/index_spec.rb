require 'rails_helper'

RSpec.describe "V1::Users::Follows::Destroy", type: :request do
  describe 'GET /' do
    let(:users) { create_list(:user, 3) }
    let(:auth_tokens) { sign_in({ email: users.first.email, password: "password" }) }

    before do
      users.each_with_index do |user, index|
        users_index = index == (users.size - 1) ? 0 : (index + 1)
        create(:follow, user: user, follow_id: users[users_index].id)
      end
    end

    context '成功系' do
      it 'フォロー数・フォロワー数取得' do
        get '/v1/users/follows', headers: auth_tokens
        json = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(json['follows']['followers'].length).to eq(1)
        expect(json['follows']['followings'].length).to eq(1)
      end

      it 'フォロワー数取得' do
        get '/v1/users/follows/followings', headers: auth_tokens
        json = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(json['followings'].length).to eq(1)
      end

      it 'フォロワー数取得' do
        get '/v1/users/follows/followers', headers: auth_tokens
        json = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(json['followers'].length).to eq(1)
      end
    end
  end
end
