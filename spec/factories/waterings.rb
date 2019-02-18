FactoryBot.define do
  factory :watering do
    water_time { Time.now + 1.day }
    completed { false }
    plant
  end
end
