FactoryBot.define do
  factory :garden do
    sequence(:zip_code) { |n| "8020#{n.to_s}" }
    sequence(:name) { |n| "Front Yard#{n}" }
    sequence(:lat) { |n| "12.#{n}"}
    sequence(:long) { |n| "-12.#{n}"}
    user
  end
end
