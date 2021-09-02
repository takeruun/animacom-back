FactoryBot.define do
  factory :pet do
    user { nil }
    name { "MyString" }
    gender { 1 }
    image { "MyString" }
    age { 1 }
  end
end
