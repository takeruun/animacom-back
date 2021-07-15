require 'rails_helper'

RSpec.describe "V1::Posts::Latest", type: :request do
  describe "GET /" do
    let!(:user) { create(:user) }
    let!(:category) { create(:category) }
    let!(:posts) { create_list :post, 1, user: user, category: category }

    it "本日投稿されたデータ取得できる" do
      get "/v1/posts/latest"
      json = JSON.parse(response.body)
      
      expect(response).to have_http_status(:success)
      expect(json['posts'].length).to eq(1)
      expect(Time.current.all_day.cover?(json['posts'][0]['created_at'])).to eq(true)
    end

    it "正しいデータが取得できる" do
      get "/v1/posts"
      json = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(json['posts'][0]['id']).to eq(posts.first.id)
      expect(json['posts'][0]['user_id']).to eq(user.id)
      expect(json['posts'][0]['title']).to eq(posts.first.title)
      expect(json['posts'][0]['sub_title']).to eq(posts.first.sub_title)
      expect(json['posts'][0]['body']).to eq(posts.first.body)
      expect(json['posts'][0]['category_id']).to eq(category.id)
    end

    it "投稿データが増える" do
      create(:post, user: user, category: category)

      get "/v1/posts/latest"
      json = JSON.parse(response.body)
      
      expect(response).to have_http_status(:success)
      expect(json['posts'].length).to eq(2)
    end
  end
end
