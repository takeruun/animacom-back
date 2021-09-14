require 'rails_helper'

RSpec.describe "V1::Users::Posts::Reactions::Destroy", type: :request do
  describe "DELETE /" do
    let!(:user) { create(:user) }
    let!(:category) { create(:category) }
    let(:auth_tokens) { sign_in({ email: user.email, password: "password" }) }

    before do
      post = create(:post, user: user, category: category)
      @reaction_cute = create(:reaction, user: user, post: post, kind: 'cute')
      @reaction_fav = create(:reaction, user: user, post: post, kind: 'fav')
      @reaction_good = create(:reaction, user: user, post: post, kind: 'good')
      @reaction_cool = create(:reaction, user: user, post: post, kind: 'cool')
    end

    it '「かわいい」削除できる' do
      delete "/v1/users/posts/reactions/#{@reaction_cute.id}", headers: auth_tokens

      expect(response).to have_http_status(:success)
    end
    
    it '「お気に入り」削除できる' do
      delete "/v1/users/posts/reactions/#{@reaction_fav.id}", headers: auth_tokens
      
      expect(response).to have_http_status(:success)
    end

    it '「いいね」削除できる' do
      delete "/v1/users/posts/reactions/#{@reaction_good.id}", headers: auth_tokens

      expect(response).to have_http_status(:success)
    end

    it '「かっこいい」削除できる' do
      delete "/v1/users/posts/reactions/#{@reaction_cool.id}", headers: auth_tokens

      expect(response).to have_http_status(:success)
    end
  end
end