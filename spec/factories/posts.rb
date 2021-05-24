FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "TEST_TITLE#{n}"}
    sequence(:sub_title) { |n| "TEST_SUBTITLELE#{n}"}
    sequence(:body) { |n| "test body #{n}"}
  end
end