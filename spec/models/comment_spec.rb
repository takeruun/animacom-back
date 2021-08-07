require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:post) { create :post, user: user, category: category }
  let!(:comment) { build :comment, user: user, post: post }

  it "登録できる" do
    expect(comment.valid?).to eq(true)
  end

  it "ユーザなし、登録できない" do
    comment.user = nil
    expect(comment.valid?).to eq(false)
  end

  it "投稿なし、登録できない" do
    comment.post = nil
    expect(comment.valid?).to eq(false)
  end
end
