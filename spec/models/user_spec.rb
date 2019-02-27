require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :google_token }
    it { should validate_presence_of :google_id }
  end

  describe 'Relationships' do
    it { should have_many(:gardens) }
  end

  describe 'class methods' do
    it 'users_with_missed_waterings' do
      create(:watering, water_time: Date.tomorrow)
      create(:watering, water_time: Date.today)

      user_1 = create(:user)
      garden_1 = create(:garden, users: [user_1])
      plant_1 = create(:plant, garden: garden_1)

      user_2 = create(:user)
      garden_2 = create(:garden, users: [user_2])
      plant_2 = create(:plant, garden: garden_2)

      watering_1 = create(:watering, water_time: Date.yesterday, plant: plant_1)
      watering_2 = create(:watering, water_time: 3.days.ago.to_date, plant: plant_2)
      watering_3 = create(:watering, water_time: 4.days.ago.to_date, plant: plant_2)

      result = User.with_missed_waterings

      expect(result.to_a.count).to eq(2)
      expect(result).to eq([user_1, user_2])
      expect(result.first.gardens).to eq([garden_1])
      expect(result.first.gardens.first.plants).to eq([plant_1])
      require 'pry'; binding.pry
      expect(result.first.gardens.first.plants.first.waterings).to eq([watering_1])
      expect(result.first.gardens).to eq([garden_2])
      expect(result.first.gardens.first.plants).to eq([plant_2])
      expect(result.first.gardens.first.plants.first.waterings).to eq([watering_2])
    end
  end
end
