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
      create(:watering, water_time: Date.today + 1.days)
      create(:watering, water_time: Date.today)

      user_1 = create(:user)
      garden_1 = create(:garden, users: [user_1])
      plant_1 = create(:plant, garden: garden_1)
      create(:plant, garden: garden_1)

      user_2 = create(:user)
      garden_2 = create(:garden, users: [user_2])
      create(:garden, users: [user_2])
      plant_2 = create(:plant, garden: garden_2)

      watering_1 = create(:watering, water_time: Date.today - 1.days, plant: plant_1)
      watering_2 = create(:watering, water_time: Date.today - 3.days, plant: plant_2)
      watering_3 = create(:watering, water_time: Date.today - 4.days, plant: plant_2)
      #This last watering is too far in the past to be concerned about
      watering_4 = create(:watering, water_time: Date.today - 5.days, plant: plant_2)

      result = User.with_missed_waterings

      expect(result.to_a.count).to eq(2)
      expect(result).to eq([user_1, user_2])
      expect(result.first.gardens).to eq([garden_1])
      expect(result.first.gardens.first.plants).to eq([plant_1])
      expect(result.first.gardens.first.plants.first.waterings).to eq([watering_1])

      expect(result.last.gardens).to eq([garden_2])
      expect(result.last.gardens.first.plants).to eq([plant_2])
      expect(result.last.gardens.first.plants.first.waterings.to_set).to eq(Set[watering_3, watering_2])
    end
  end

  describe 'Instance Methods' do
    describe '#own_gardens' do
      it 'should return the gardens for which the user is the owner' do
        owner = create(:user)
        garden_1 = create(:garden, owners: [owner])
        garden_2 = create(:garden, owners: [owner])
        not_owner = create(:user)
        garden_3 = create(:garden, owners: [not_owner])
        create(:user_garden, garden: garden_3, user: owner, relationship_type: 'caretaker')

        expect(owner.own_gardens.to_set).to eq(Set[garden_1, garden_2])
        expect(not_owner.own_gardens).to eq([garden_3])
      end
    end
    describe '#caretaking_gardens' do
      it 'should return the gardens for which the user is the caretaker' do
        owner = create(:user)
        garden_1 = create(:garden, owners: [owner])
        garden_2 = create(:garden, owners: [owner])
        not_owner = create(:user)
        garden_3 = create(:garden, owners: [not_owner])
        create(:user_garden, garden: garden_3, user: owner, relationship_type: 'caretaker')

        expect(owner.caretaking_gardens).to eq([garden_3])
        expect(not_owner.caretaking_gardens).to eq([])
      end
    end
  end
end
