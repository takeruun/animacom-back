require 'rails_helper'

RSpec.describe "V1::Users::Follows::Destroy", type: :request do
  describe "DELETE /" do
    let(:users) { create_list(:user, 3) }
    let(:auth_tokens) { sign_in({ email: users.first.email, password: "password" }) }

    context 'ログイン時' do
      before do
        create(:follow, user: users.first, follow_id: users[1].id)
      end

      it 'フォロー解除できる' do
        delete '/v1/users/follows', headers: auth_tokens,
        params: {
          follow_id: users[1].id
        }
        json = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(json['followings'].length).to eq(0)
      end
    end

    context '失敗系' do
      it 'フォロー解除できない' do
        delete '/v1/users/follows', headers: auth_tokens,
        params: {
          follow_id: users[1].id
        }
        json = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(json['error']).to eq('フォロー解除に失敗しました。')
        expect(json['msg']).to eq("#{users[1].name}はフォローしていません。")
      end
    end
  end
end