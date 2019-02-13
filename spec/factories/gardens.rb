FactoryBot.define do
  factory :garden do
    sequence(:zip_code) { |n| "8020#{n.to_s}" }
    sequence(:name) { |n| "Front Yard#{n}" }
  end
end
