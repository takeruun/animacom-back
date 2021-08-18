require 'rails_helper'

RSpec.describe "V1::Users::Update", type: :request do
  describe "UPDATE /" do
    let!(:user) { create(:user) }
    let(:auth_tokens) { sign_in({ email: user.email, password: "password" }) }

    context '成功系' do
      it 'ユーザ情報を更新' do
        put '/v1/users', headers: auth_tokens,
        params: {
          user: {
            name: 'UPDATE_NAME',
            nickname: 'UPDATE_NICK_NAME',
          }
        }
        json = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(json['user']['id']).to eq(user.id)
        expect(json['user']['name']).to eq('UPDATE_NAME')
        expect(json['user']['nickname']).to eq('UPDATE_NICK_NAME')
      end
    end

    context '失敗系' do
      it '名前無し：ユーザ情報更新できない' do
        put '/v1/users', headers: auth_tokens,
        params: {
          user: {
            name: '',
            nickname: 'UPDATE_NICK_NAME',
          }
        }
        json = JSON.parse(response.body)

        expect(response.status).to eq(400)
        expect(json['error']).to eq('ユーザ情報更新失敗しました。')
        expect(json['msg'][0]).to eq('名前を入力してください')
      end
    end
  end
end