require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { build(:user) }

  it "登録できる" do
    expect(user.valid?).to eq(true)
  end

  it "名前なし、登録できない" do
    user.name = ''
    expect(user.valid?).to eq(false)
  end

  it "メールアドレスなし, 登録できない" do
    user.email = ''
    expect(user.valid?).to eq(false)
  end

  it "パスワードなし、登録できない" do
    user.password = ''
    expect(user.valid?).to eq(false)
  end
end

