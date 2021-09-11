require 'rails_helper'

RSpec.describe "V1::Follows::Index", type: :request do
  describe 'GET /followings/:user_id' do
    let(:user) { create(:user) }
    let(:user_2) { create(:user) }
    let!(:users) { create_list(:user, 4) }
    let(:auth_tokens) { sign_in({ email: user.email, password: "password" }) }

    before do
      users.each do |f_user|
        create(:follow, user: user_2, follow_id: f_user.id)
        create(:follow, user: f_user, follow_id: user_2.id)
      end
    end

    it 'フォローしているユーザ取得できる' do
      get "/v1/follows/followings/#{user_2.id}", headers: auth_tokens

      json = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(json['users'].length).to eq(4)
    end

    it 'フォロワーのユーザを取得できる' do
      get "/v1/follows/followers/#{user_2.id}", headers: auth_tokens

      json = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(json['users'].length).to eq(4)
    end

    it 'フォローユーザ中、誰もフォローしていない' do
      get "/v1/follows/followings/#{user_2.id}", headers: auth_tokens

      json = JSON.parse(response.body)

      expect(response).to have_http_status(:success)

      json['users'].each do |res|
        expect(res['follow']).to eq(false)
      end
    end

    it 'フォロワーユーザ中、誰もフォローしていない' do
      get "/v1/follows/followers/#{user_2.id}", headers: auth_tokens

      json = JSON.parse(response.body)

      expect(response).to have_http_status(:success)

      json['users'].each do |res|
        expect(res['follow']).to eq(false)
      end
    end

    it 'フォローユーザ中、1人フォローしている' do
      create(:follow, user: user, follow_id: users.last.id)
      get "/v1/follows/followings/#{user_2.id}", headers: auth_tokens

      json = JSON.parse(response.body)

      expect(response).to have_http_status(:success)

      json['users'].each do |res|
        if res['id'] == users.last.id
          expect(res['follow']).to eq(true)
        else
          expect(res['follow']).to eq(false)
        end
      end
    end

    it 'フォロワーユーザ中、1人フォローしている' do
      create(:follow, user: user, follow_id: users.first.id)
      get "/v1/follows/followers/#{user_2.id}", headers: auth_tokens

      json = JSON.parse(response.body)

      expect(response).to have_http_status(:success)

      json['users'].each do |res|
        if res['id'] == users.first.id
          expect(res['follow']).to eq(true)
        else
          expect(res['follow']).to eq(false)
        end
      end
    end
  end
end