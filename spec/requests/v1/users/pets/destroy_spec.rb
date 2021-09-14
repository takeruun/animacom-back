require 'rails_helper'

RSpec.describe "V1::Users::Pets::Destroy", type: :request do
  describe 'DELETE /:id' do
    let!(:user) { create(:user) }
    let!(:pet) { create(:pet, user: user) }
    let(:auth_tokens) { sign_in({ email: user.email, password: "password" }) }

    it '削除できる' do
      delete "/v1/users/pets/#{pet.id}", headers: auth_tokens

      json = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
    end

    context '失敗系' do
      it '既に削除している' do
        pet_id = pet.id
        pet.destroy

        delete "/v1/users/pets/#{pet_id}", headers: auth_tokens

        json = JSON.parse(response.body)
        expect(response).to have_http_status(:success)
        expect(json['error']).to eq('削除に失敗しました。')
      end
    end
  end
end