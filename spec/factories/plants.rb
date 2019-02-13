FactoryBot.define do
  factory :plant do
    sequence(:name) { |n| "Plant #{n}" }
    sequence(:times_per_week) { |n| n }
    garden
  end
end
