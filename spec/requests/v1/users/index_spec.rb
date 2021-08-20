require 'rails_helper'

RSpec.describe "V1::Users::Index", type: :request do
  describe 'GET /' do
    let(:user) { create(:user) }
    let!(:users) { create_list(:user, 4) }
    let(:auth_tokens) { sign_in({ email: user.email, password: "password" }) }

    context '成功系' do
      it 'ユーザ一覧取得できる（自分以外）' do
        get '/v1/users/', headers: auth_tokens

        json = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(json['users'].length).to eq(4)
      end
    end
  end
end