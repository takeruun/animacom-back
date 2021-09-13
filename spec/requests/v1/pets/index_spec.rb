require 'rails_helper'

RSpec.describe "V1::Pets::Index", type: :request do
  describe "GET /" do
    let!(:user) { create(:user) }
    let!(:pet) { create(:pet, user: user) }

    it 'userのペット一覧を取得できる' do
      get "/v1/pets/users/#{user.id}"

      json = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(json['pets'][0]['id']).to eq(pet.id)
      expect(json['pets'][0]['name']).to eq(pet.name)
      expect(json['pets'][0]['age']).to eq(pet.age)
      expect(json['pets'][0]['gender']['id']).to eq(pet.gender_before_type_cast)
      expect(json['pets'][0]['gender']['name']).to eq(pet.gender_i18n)
    end

    it '複数の場合' do
      create(:pet, user: user)

      get "/v1/pets/users/#{user.id}"

      json = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(json['pets'].length).to eq(2)
    end
  end
end