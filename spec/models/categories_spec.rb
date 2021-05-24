require 'rails_helper'

RSpec.describe Category, type: :model do
  let!(:category) { build(:category) }
  let!(:category_1) { build(:category) }

  it "作成できる" do
    expect(category.valid?).to eq(true)
  end

  it "同じ名前は、作成できない" do
    category.save
    category_1.name = category.name
    expect(category_1.valid?).to eq(false)
  end

  it "名前なし、作成できない" do
    category.name = ''
    expect(category.valid?).to eq(false)
  end
end