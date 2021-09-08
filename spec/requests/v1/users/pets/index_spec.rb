require 'rails_helper'

RSpec.describe "V1::Users::Pets::Index", type: :request do
  describe 'GET / ' do
    let!(:user) { create(:user) }
    let!(:pet) { create(:pet, user: user) }
    let(:auth_tokens) { sign_in({ email: user.email, password: "password" }) }

    it '情報一覧を取得できる' do
      get '/v1/users/pets', headers: auth_tokens

      json = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(json['pets'][0]['id']).to eq(pet.id)
      expect(json['pets'][0]['name']).to eq(pet.name)
      expect(json['pets'][0]['age']).to eq(pet.age)
      expect(json['pets'][0]['gender']).to eq(pet.gender_i18n)
    end

    it '複数の場合' do
      create(:pet, user: user)

      get '/v1/users/pets', headers: auth_tokens

      json = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(json['pets'].length).to eq(2)
    end
  end
end