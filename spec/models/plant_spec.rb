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
end
