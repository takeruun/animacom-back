FactoryBot.define do
  factory :pet do
    user { nil }
    name { "MyString" }
    gender { 1 }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.png')) }
    age { 1 }
  end
end
