require 'rails_helper'

RSpec.describe Pet, type: :model do
  let!(:user) { create(:user) }
  let!(:pet) { build(:pet, user: user) }

  it '作成できる' do
    expect(pet.valid?).to eq(true)
  end

  describe '作成できない' do
    it 'ユーザなし' do
      pet.user = nil
      expect(pet.valid?).to eq(false)
    end

    it '名前なし' do
      pet.name = nil
      expect(pet.valid?).to eq(false)
    end

    it '年齢なし' do
      pet.age = nil
      expect(pet.valid?).to eq(false)
    end

    it '性別なし' do
      pet.gender = nil
      expect(pet.valid?).to eq(false)
    end
  end
end
