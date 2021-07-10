FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "TEST_NAME#{n}"}
    sequence(:email) { |n| "TEST#{n}@example.com"}
    sequence(:nickname) { |n| "test_#{n}"}
    sequence(:password) { |n| "password"}

    trait(:with_posts) do
      after(:create) do |user, evaluator|
        create_list(:post, 1, user: user)
      end
    end
  end
end