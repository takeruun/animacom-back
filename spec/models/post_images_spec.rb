require 'rails_helper'

RSpec.describe PostImage, type: :model do
  let!(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:post) { create(:post, user: user, category: category) }
  let(:post_image) { build(:post_image, post: post) }
  let(:post_images) { create_list(:post_image, 2, post: post) }

  it '画像保存できる' do
    expect(post_image.valid?).to eq(true)
  end

  it '画像複数登録できる' do
    post_images.each do |image|
      expect(post_image.valid?).to eq(true)
    end
  end

  it '投稿がないと画像は登録できない' do
    post_image.post_id  = nil
    expect(post_image.valid?).to eq(false)
  end
end