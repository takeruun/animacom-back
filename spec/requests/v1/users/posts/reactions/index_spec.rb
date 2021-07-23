require 'rails_helper'

RSpec.describe "V1::Users::Posts::Reactions::Index", type: :request do
  describe "GET /" do
    let(:user) { create(:user) }
    let!(:category) { create(:category) }
    let!(:posts) { create_list :post, 8, user: user, category: category }

    before do
      kinds = ['cute', 'fav', 'cool', 'good']
      posts.each_slice(2).to_a.each.with_index do |targets, index|
        targets.each do |post|
          create(:reaction, post: post, user: user, kind: kinds[index])
        end
      end
    end

    shared_examples '「かわいい」が2件取れる' do
      it do
        if defined?(auth_tokens)
          get '/v1/users/posts/reactions', headers: auth_tokens,
            params: { reactions: {
              kind: 'cute'
              },
            }
        else
          get '/v1/users/posts/reactions',
          params: { reactions: {
            kind: 'cute'
            },
          }
        end

        json = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(json['posts'].length).to eq(2)
        expect(json['posts'][0]['reactions'][0]['kind']).to eq(1)
      end
    end

    shared_examples '「お気に入り」が2件取れる' do
      it do
        if defined?(auth_tokens)
          get '/v1/users/posts/reactions', headers: auth_tokens,
            params: { reactions: {
              kind: 'fav'
              },
            }
        else
          get '/v1/users/posts/reactions',
          params: { reactions: {
            kind: 'fav'
            },
          }
        end

        json = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(json['posts'].length).to eq(2)
        expect(json['posts'][0]['reactions'][0]['kind']).to eq(2)
      end
    end

    shared_examples '「いいね」が2件取れる' do
      it do
        if defined?(auth_tokens)
          get '/v1/users/posts/reactions', headers: auth_tokens,
            params: { reactions: {
              kind: 'good'
              },
            }
        else
          get '/v1/users/posts/reactions',
          params: { reactions: {
            kind: 'good'
            },
          }
        end

        json = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(json['posts'].length).to eq(2)
        expect(json['posts'][0]['reactions'][0]['kind']).to eq(3)
      end
    end

    shared_examples '「かっこいい」が2件取れる' do
      it do
        if defined?(auth_tokens)
          get '/v1/users/posts/reactions', headers: auth_tokens,
            params: { reactions: {
              kind: 'cool'
              },
            }
        else
          get '/v1/users/posts/reactions',
          params: { reactions: {
            kind: 'cool'
            },
          }
        end

        json = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(json['posts'].length).to eq(2)
        expect(json['posts'][0]['reactions'][0]['kind']).to eq(4)
      end
    end

    context 'ログイン時' do
      let(:auth_tokens) { sign_in({ email: user.email, password: "password" }) }

      it_behaves_like '「かわいい」が2件取れる'
      it_behaves_like '「お気に入り」が2件取れる'
      it_behaves_like '「いいね」が2件取れる'
      it_behaves_like '「かっこいい」が2件取れる'
    end

  end
end