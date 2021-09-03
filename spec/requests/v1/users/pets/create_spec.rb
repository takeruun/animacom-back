require 'rails_helper'

RSpec.describe "V1::Users::Pets::Create", type: :request do
  describe 'POST /' do
    let!(:user) { create(:user) }
    let(:auth_tokens) { sign_in({ email: user.email, password: "password" }) }

    it '登録できる' do
      post "/v1/users/pets", headers: auth_tokens, params: {
        pets: {
          name: 'test',
          age: 1,
          gender: 0,
          image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.png')),
        }
      }

      json = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(json['pet']['name']).to eq('test')
      expect(json['pet']['age']).to eq(1)
      expect(json['pet']['gender']).to eq('オス')
    end

    context '失敗系' do
      it '名前なし' do
        post "/v1/users/pets", headers: auth_tokens, params: {
          pets: {
            age: 1,
            gender: 0,
            image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.png')),
          }
        }
  
        json = JSON.parse(response.body)
        expect(response).to have_http_status(:success)
        expect(json['error']).to eq('ペット登録失敗しました。')
        expect(json['msg'][0]).to eq('名前を入力してください')
      end

      it '年齢なし' do
        post "/v1/users/pets", headers: auth_tokens, params: {
          pets: {
            name: 'test',
            gender: 0,
            image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.png')),
          }
        }
  
        json = JSON.parse(response.body)
        expect(response).to have_http_status(:success)
        expect(json['error']).to eq('ペット登録失敗しました。')
        expect(json['msg'][0]).to eq('年齢を入力してください')
      end

      it '性別なし' do
        post "/v1/users/pets", headers: auth_tokens, params: {
          pets: {
            name: 'test',
            age: 1,
            image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.png')),
          }
        }
        json = JSON.parse(response.body)
        expect(response).to have_http_status(:success)
        expect(json['error']).to eq('ペット登録失敗しました。')
        expect(json['msg'][0]).to eq('性別を入力してください')
      end

      it '写真なし' do
        post "/v1/users/pets", headers: auth_tokens, params: {
          pets: {
            name: 'test',
            age: 1,
            gender: 0,
          }
        }
  
        json = JSON.parse(response.body)
        expect(response).to have_http_status(:success)
        expect(json['error']).to eq('ペット登録失敗しました。')
        expect(json['msg'][0]).to eq('写真を入力してください')
      end
    end  
  end
end