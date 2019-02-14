FactoryBot.define do
  factory :watering do
    water_time { Date.today + 1.day }
    completed { false }
    plant
  end
end
