require 'rails_helper'

RSpec.describe "V1::Users::Posts::Destroy", type: :request do
  describe "POST /" do
    context "ログイン時" do
      let!(:user) { create(:user) }
      let!(:category) { create(:category) }
      let(:auth_tokens) { sign_in({ email: user.email, password: "password" }) }

      before do
        @post = create(:post, user: user, category: category)
        @image = create(:post_image, post: @post)
        @category = create(:category)
      end

      it "削除できる" do
        delete "/v1/users/posts/#{@post.id}", headers: auth_tokens

        expect(response).to have_http_status(:success)
      end
    end
  end
end
