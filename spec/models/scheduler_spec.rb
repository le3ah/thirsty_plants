require 'rails_helper'

describe Scheduler do
  it 'exists' do
    expect(Scheduler).to be_a(Object)
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

  it '.generate_waterings' do
    plant_1 = create(:plant, times_per_week: 7)
    plant_2 = create(:plant, times_per_week: 1)
    [plant_1, plant_2].each do |plant|
      plant.waterings.each do |watering|
        watering.update(water_time: watering.water_time - 1.day)
      end
    end
    plant_1 = plant_1.reload
    plant_2 = plant_2.reload
    one_week_from_today = Date.today + 1.week
    Scheduler.generate_waterings(one_week_from_today)
    expect(Watering.where(water_time: one_week_from_today).count).to eq(1)
  end
end
