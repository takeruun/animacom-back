require 'rails_helper'

RSpec.describe "V1::Users::Follows::Create", type: :request do
  describe "POST /" do
    let(:users) { create_list(:user, 3) }
    let(:auth_tokens) { sign_in({ email: users.first.email, password: "password" }) }

    context '成功系' do
      it 'フォローできる' do
        post '/v1/users/follows', headers: auth_tokens,
        params: {
          follow_id: users[1].id
        }
        json = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(json['followings'].length).to eq(1)
        expect(json['followings'][0]['id']).to eq(users[1].id)
        expect(json['followings'][0]['name']).to eq(users[1].name)
        expect(json['followings'][0]['nickname']).to eq(users[1].nickname)
      end
    end

    context '失敗系' do
      before do
        create(:follow, user: users.first, follow_id: users[1].id)
      end

      it 'フォローしているとフォローできない' do
        post '/v1/users/follows', headers: auth_tokens,
        params: {
          follow_id: users[1].id
        }
        json = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(json['error']).to eq('フォローに失敗しました。')
        expect(json['msg']).to eq("#{users[1].name}は既にフォローしています。")
      end
    end
  end
end