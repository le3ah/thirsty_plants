require 'rails_helper'

RSpec.describe Plant, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :times_per_week}
    it { should validate_numericality_of(:times_per_week).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:times_per_week).is_less_than_or_equal_to(35) }
  end

  describe 'Relationships' do
    it { should belong_to :garden }
    it { should have_many :waterings }
  end

  describe 'callbacks' do
    it 'generates waterings after create' do
      plant = create(:plant, times_per_week: 5)
      expect(plant.reload.waterings.size).to eq(5)

      create(:watering, water_time: Date.yesterday, plant: plant)
      expect(plant.reload.waterings.size).to eq(6)
    end
  end
  describe 'instance methods' do
    it 'projected_thirstiness_of_plant_on' do
      plant_1 = create(:plant, times_per_week: 4)
      plant_1.reload
      expect(plant_1.projected_thirstiness_of_plant_on(Time.now.to_date + 8)).to eq(1.1428571428571423)
      expect(plant_1.projected_thirstiness_of_plant_on(Time.now.to_date + 2)).to eq(0.7142857142857142)
      expect(plant_1.projected_thirstiness_of_plant_on(Time.now.to_date + 15)).to eq(5.142857142857142)
    end
    it 'todays_waterings' do
      plant = create(:plant, times_per_week: 7)
      expect(plant.todays_waterings.count).to eq(1)
      expect(plant.todays_waterings).to eq([plant.waterings.first])
      
      plant_2 = create(:plant, times_per_week: 1)
      expect(plant.todays_waterings.count).to eq()
      expect(plant.todays_waterings).to eq([])
    end
  end
end
