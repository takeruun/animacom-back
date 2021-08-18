require 'rails_helper'

RSpec.describe "V1::Users::Posts::Reactions::Create", type: :request do
  describe "POST /" do
    let!(:user) { create(:user) }
    let!(:category) { create(:category) }
    let(:auth_tokens) { sign_in({ email: user.email, password: "password" }) }

    context "成功系" do
      before do
        @post = create(:post, user: user, category: category)
      end

      it '「かわいい」できる' do
        post "/v1/users/posts/reactions/#{@post.id}", headers: auth_tokens,
          params: {
            reaction: {
              kind: "cute"
            }
          }

        json = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(json['post']['cute_count']).to eq(1)
        expect(json['post']['fav_count']).to eq(0)
        expect(json['post']['good_count']).to eq(0)
        expect(json['post']['cool_count']).to eq(0)
        expect(json['post']['already_cuted']).to eq(true)

      end
      
      it '「お気に入り」できる' do
        post "/v1/users/posts/reactions/#{@post.id}", headers: auth_tokens,
          params: {
            reaction: {
              kind: "fav"
            }
          }

        json = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(json['post']['cute_count']).to eq(0)
        expect(json['post']['fav_count']).to eq(1)
        expect(json['post']['good_count']).to eq(0)
        expect(json['post']['cool_count']).to eq(0)
        expect(json['post']['already_faved']).to eq(true)
      end

      it '「いいね」できる' do
        post "/v1/users/posts/reactions/#{@post.id}", headers: auth_tokens,
          params: {
            reaction: {
              kind: "good"
            }
          }

        json = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(json['post']['cute_count']).to eq(0)
        expect(json['post']['fav_count']).to eq(0)
        expect(json['post']['good_count']).to eq(1)
        expect(json['post']['cool_count']).to eq(0)
        expect(json['post']['already_gooded']).to eq(true)
      end

      it '「かっこいい」できる' do
        post "/v1/users/posts/reactions/#{@post.id}", headers: auth_tokens,
          params: {
            reaction: {
              kind: "cool"
            }
          }

        json = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(json['post']['cute_count']).to eq(0)
        expect(json['post']['fav_count']).to eq(0)
        expect(json['post']['good_count']).to eq(0)
        expect(json['post']['cool_count']).to eq(1)
        expect(json['post']['already_cooled']).to eq(true)
      end
    end

    context '失敗系' do
      before do
        @post = create(:post, user: user, category: category)
        create(:reaction, user: user, post: @post, kind: 'cute')
        create(:reaction, user: user, post: @post, kind: 'fav')
        create(:reaction, user: user, post: @post, kind: 'good')
        create(:reaction, user: user, post: @post, kind: 'cool')
      end

      describe '2回リアクションできない' do
        it '「かわいい」できない' do
          post "/v1/users/posts/reactions/#{@post.id}", headers: auth_tokens,
          params: {
            reaction: {
              kind: "cute"
            }
          }
          json = JSON.parse(response.body)

          expect(response.status).to eq(400)
          expect(json['error']).to eq('かわいいに失敗しました。')          
          expect(json['msg'][0]).to eq('リアクションは各1回しかできません。')
        end

        it '「お気に入り」できない' do
          post "/v1/users/posts/reactions/#{@post.id}", headers: auth_tokens,
          params: {
            reaction: {
              kind: "fav"
            }
          }
          json = JSON.parse(response.body)

          expect(response.status).to eq(400)
          expect(json['error']).to eq('お気に入りに失敗しました。')
          expect(json['msg'][0]).to eq('リアクションは各1回しかできません。')
        end

        it '「いいね」できない' do
          post "/v1/users/posts/reactions/#{@post.id}", headers: auth_tokens,
          params: {
            reaction: {
              kind: "good"
            }
          }
          json = JSON.parse(response.body)

          expect(response.status).to eq(400)
          expect(json['error']).to eq('いいねに失敗しました。')          
          expect(json['msg'][0]).to eq('リアクションは各1回しかできません。')
        end

        it '「かっこいい」できない' do
          post "/v1/users/posts/reactions/#{@post.id}", headers: auth_tokens,
          params: {
            reaction: {
              kind: "cool"
            }
          }
          json = JSON.parse(response.body)

          expect(response.status).to eq(400)
          expect(json['error']).to eq('かっこいいに失敗しました。')          
          expect(json['msg'][0]).to eq('リアクションは各1回しかできません。')
        end
      end
    end
  end
end
