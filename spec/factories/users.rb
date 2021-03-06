FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "TEST_NAME#{n}"}
    sequence(:email) { |n| "TEST#{n}@example.com"}
    sequence(:nickname) { |n| "test_#{n}"}
    sequence(:password) { |n| "password"}
    sequence(:introduction) { |n| "introduction_#{n}" }
    sequence(:image) { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.png')) }

    trait(:with_posts) do
      after(:create) do |user, evaluator|
        create_list(:post, 1, user: user)
      end
    end
  end
end