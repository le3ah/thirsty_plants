FactoryBot.define do
  factory :watering do
    water_time { Date.today }
    completed { false }
    plant
  end
end
