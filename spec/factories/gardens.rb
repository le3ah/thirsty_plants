FactoryBot.define do
  factory :garden do
    sequence(:zip_code) { |n| "8020#{n.to_s}" }
    sequence(:name) { |n| "Front Yard#{n}" }
    lat { 12.10 }
    long { -12.10 }
    after :create do |garden|
      if garden.users.empty?
        create :user_garden, garden: garden
      end
    end
  end
end
