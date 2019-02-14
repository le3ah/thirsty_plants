FactoryBot.define do
  factory :watering do
    watertime { "2019-02-14 11:33:04" }
    completed { false }
    plant { nil }
  end
end
