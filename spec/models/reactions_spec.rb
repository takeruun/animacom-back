require 'rails_helper'

RSpec.describe Reaction, type: :model do
  let!(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:post) { create(:post, user: user, category: category) }
  let!(:reaction) { build(:reaction, user: user, post: post) }

  it '「かわいい」作成できる' do
    reaction.kind = 'cute'
    expect(reaction.valid?).to eq(true)
  end

  it '「お気に入り」作成できる' do
    reaction.kind = 'fav'
    expect(reaction.valid?).to eq(true)
  end

  it '「いいね」作成できる' do
    reaction.kind = 'good'
    expect(reaction.valid?).to eq(true)
  end

  it '「かっこいい」作成できる' do
    reaction.kind = 'cool'
    expect(reaction.valid?).to eq(true)
  end

  it '2つは作成できない' do
    reaction.kind = 'cute'
    reaction.save

    reaction = build(:reaction, user: user, kind: 'cute', post: post)
    expect(reaction.valid?).to eq(false)
  end
end