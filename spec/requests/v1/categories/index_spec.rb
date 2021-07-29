require 'rails_helper'

RSpec.describe "V1::Categories::Index", type: :request do
  describe "GET /" do
    let!(:user) { create(:user) }
    let!(:categories) { create_list(:category, 3) }
    
    shared_examples '全カテゴリが取得できる' do
      it do
        if defined?(auth_tokens)
          get '/v1/categories', headers: auth_tokens
        else
          get '/v1/categories'
        end
        json = JSON.parse(response.body)
        
        expect(response).to have_http_status(:success)
        expect(json['categories'].length).to eq(categories.count)
      end
    end

    shared_examples '正しいカテゴリが取得できる' do
      it do
        if defined?(auth_tokens)
          get '/v1/categories', headers: auth_tokens
        else
          get '/v1/categories'
        end
        json = JSON.parse(response.body)
        
        expect(response).to have_http_status(:success)
        expect(json['categories'][0]['id']).to eq(categories.first.id.to_s)
      end
    end

    context 'ログイン時' do
      let(:auth_tokens) { sign_in({ email: user.email, password: "password" }) }

      it_behaves_like '全カテゴリが取得できる'
      it_behaves_like '正しいカテゴリが取得できる'
    end

    context 'ログインなし' do
      it_behaves_like '全カテゴリが取得できる'
      it_behaves_like '正しいカテゴリが取得できる'
    end
  end
end
