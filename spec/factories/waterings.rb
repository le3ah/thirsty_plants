FactoryBot.define do
  factory :watering do
    water_time { Time.now.to_date }
    completed { false }
    plant
  end
end
