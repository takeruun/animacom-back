require 'rails_helper'

RSpec.describe "V1::Users::Auth::Registrations", type: :request do
  describe 'POST /' do

    context '成功系' do
      it 'ユーザ作成できる' do
        post '/v1/users/auth/',
        params: {
          email: 'test@mail.com',
          name: 'TEST',
          nickname: 'NICKNAME_TEST',
          password: '12345678',
          image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.png')),
        }
        json = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(json['user']['name']).to eq('TEST')
        expect(json['user']['nickname']).to eq('NICKNAME_TEST')
        expect(json['user']['image']['image_path'].present?).to eq(true)
      end
    end
  end
end