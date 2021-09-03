require 'rails_helper'

RSpec.describe "V1::Users::Show", type: :request do
  describe "GET /my_page" do
    let!(:user) { create(:user) }
    let!(:pet) { create(:pet, user: user )}
    let(:auth_tokens) { sign_in({ email: user.email, password: "password" }) }

    it '自分の情報を取得できる' do
      get '/v1/users/my_page', headers: auth_tokens
      json = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(json['user']['id']).to eq(user.id)
      expect(json['user']['name']).to eq(user.name)
      expect(json['user']['nickname']).to eq(user.nickname)
      expect(json['user']['pet_count']).to eq(1)
    end
  end

  describe 'GET /:id' do
    let!(:user) { create(:user) }
    let!(:other_user){ create(:user) }
    let!(:pet) { create(:pet, user: other_user )}
    let(:auth_tokens) { sign_in({ email: user.email, password: "password" }) }

    it 'ユーザの情報を取得できる' do
      get "/v1/users/#{other_user.id}", headers: auth_tokens
      json = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(json['user']['id']).to eq(other_user.id)
      expect(json['user']['name']).to eq(other_user.name)
      expect(json['user']['nickname']).to eq(other_user.nickname)
      expect(json['user']['pet_count']).to eq(1)
    end
  end
end