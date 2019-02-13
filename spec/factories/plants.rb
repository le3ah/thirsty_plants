FactoryBot.define do
  factory :plant do
    name { "MyString" }
    times_per_week { 1.5 }
    garden { nil }
  end
end
