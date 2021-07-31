require 'rails_helper'

RSpec.describe "V1::Users::Show", type: :request do
  describe "GET /" do
    let!(:user) { create(:user) }
    let(:auth_tokens) { sign_in({ email: user.email, password: "password" }) }

    it 'ユーザ情報を取得できる' do
      get '/v1/users', headers: auth_tokens
      json = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(json['user']['id']).to eq(user.id)
      expect(json['user']['name']).to eq(user.name)
      expect(json['user']['nickname']).to eq(user.nickname)
    end
  end
end