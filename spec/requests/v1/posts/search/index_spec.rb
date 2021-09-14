require 'rails_helper'

RSpec.describe "V1::Posts::Search::Index", type: :request do
  let!(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:posts) { create_list :post, 5, user: user, category: category }

  shared_examples '投稿検索できる' do
    it do
      get '/v1/posts/search',
      params: {
        keyword: 'TEST',
      }

      json = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(json['posts'].length).to eq(5)
    end
  end

  context 'ログイン時' do
    it_behaves_like '投稿検索できる'
  end
end