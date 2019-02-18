require 'rails_helper'

describe Scheduler do
  it 'exists' do
    s = Scheduler.new(double('user'))
    expect(s).to be_a(Scheduler)
  end
  it 'generate_plant_schedule' do
    plant = create(:plant, times_per_week: 3)
    plant_2 = create(:plant, garden: plant.garden, times_per_week: 4)
    plant = plant.reload
    plant_2 = plant_2.reload
    expect(plant.waterings.count).to eq(3)
    expect(plant.waterings.first.water_time.beginning_of_day).to eq(2.days.from_now.beginning_of_day)
    expect(plant.waterings.second.water_time.beginning_of_day).to eq(4.days.from_now.beginning_of_day)
    expect(plant.waterings.third.water_time.beginning_of_day).to eq(6.days.from_now.beginning_of_day)

    expect(plant_2.waterings.count).to eq(4)
    expect(plant_2.waterings.first.water_time.beginning_of_day).to eq(1.days.from_now.beginning_of_day)
    expect(plant_2.waterings.second.water_time.beginning_of_day).to eq(3.days.from_now.beginning_of_day)
    expect(plant_2.waterings.third.water_time.beginning_of_day).to eq(5.days.from_now.beginning_of_day)
    expect(plant_2.waterings.fourth.water_time.beginning_of_day).to eq(7.days.from_now.beginning_of_day)
  end
end
