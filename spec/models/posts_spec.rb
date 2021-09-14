require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:post) { build :post, user: user, category: category }

  it "登録できる" do
    expect(post.valid?).to eq(true)
  end

  it "ユーザなし、登録できない" do
    post.user = nil
    expect(post.valid?).to eq(false)
  end

  it "カテゴリなし、登録できない" do
    post.category = nil
    expect(post.valid?).to eq(false)
  end

  it "タイトルなし、登録できない" do
    post.title = ''
    expect(post.valid?).to eq(false)
  end

  it "説明なし、登録できない" do
    post.body = ''
    expect(post.valid?).to eq(false)
  end
end

