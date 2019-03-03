require 'rails_helper'

RSpec.describe Watering, type: :model do
  describe 'relationships' do
    it { should belong_to :plant}
  end
  describe 'validations' do
    it { should validate_presence_of :water_time }
  end
  describe 'class methods' do
    it '.all_missed' do
      create(:watering, water_time: Date.today + 1.days)
      create(:watering, water_time: Date.today)

      watering_1 = create(:watering, water_time: Date.today - 1.days)
      watering_2 = create(:watering, water_time: 3.days.ago.to_date)
      watering_3 = create(:watering, water_time: 4.days.ago.to_date)
      expect(Watering.all_missed).to eq([watering_1, watering_2, watering_3])
    end
  end
end
