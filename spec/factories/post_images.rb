FactoryBot.define do
  factory :post_image do
    sequence(:image) { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.png')) }
  end
end