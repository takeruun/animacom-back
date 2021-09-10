require 'rails_helper'

RSpec.describe "V1::Users::Pets::Show", type: :request do
  describe 'GET /:id ' do
    let!(:user) { create(:user) }
    let!(:pet) { create(:pet, user: user) }
    let(:auth_tokens) { sign_in({ email: user.email, password: "password" }) }

    it '詳細を取得できる' do
      get "/v1/users/pets/#{pet.id}", headers: auth_tokens

      json = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(json['pet']['id']).to eq(pet.id)
      expect(json['pet']['name']).to eq(pet.name)
      expect(json['pet']['age']).to eq(pet.age)
      expect(json['pet']['gender']['id']).to eq(pet.gender_before_type_cast)
      expect(json['pet']['gender']['name']).to eq(pet.gender_i18n)
    end
  end
end