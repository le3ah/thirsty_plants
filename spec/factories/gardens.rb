FactoryBot.define do
  factory :garden do
    zip_code { "MyString" }
    sequence(:name) { |n| "Garden #{n}" }
    user
  end
end
