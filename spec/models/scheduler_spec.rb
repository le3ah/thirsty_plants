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
    expect(Date.parse(plant.waterings.first.water_time.to_s)).to eq(Date.parse(2.days.from_now.localtime.to_s))
    expect(Date.parse(plant.waterings.second.water_time.to_s)).to eq(Date.parse(4.days.from_now.localtime.to_s))
    expect(Date.parse(plant.waterings.third.water_time.to_s)).to eq(Date.parse(6.days.from_now.localtime.to_s))

    expect(plant_2.waterings.count).to eq(4)
    expect(Date.parse(plant_2.waterings.first.water_time.to_s)).to eq(Date.parse(1.days.from_now.localtime.to_s))
    expect(Date.parse(plant_2.waterings.second.water_time.to_s)).to eq(Date.parse(3.days.from_now.localtime.to_s))
    expect(Date.parse(plant_2.waterings.third.water_time.to_s)).to eq(Date.parse(5.days.from_now.localtime.to_s))
    expect(Date.parse(plant_2.waterings.fourth.water_time.to_s)).to eq(Date.parse(7.days.from_now.localtime.to_s))
  end

  it '.generate_waterings_for_a_week_from_today' do
    def a_day_goes_by(plants)
      plants.each do |plant|
        plant.waterings.each do |watering|
          #simulating the passage of time
          watering.update(water_time: (watering.water_time - 1.day).localtime)
        end
      end
      Scheduler.generate_waterings_for_a_week_from_today
    end
    plant_1 = create(:plant, times_per_week: 7)
    plant_2 = create(:plant, times_per_week: 3)
    one_week_from_today = (Time.now + 1.week).localtime.to_date

    a_day_goes_by([plant_1, plant_2])
    expect(plant_1.reload.waterings.count).to eq(9)
    expect(plant_2.reload.waterings.count).to eq(3)
    expect(Watering.where(water_time: one_week_from_today).count).to eq(1)
    a_day_goes_by([plant_1, plant_2])
    expect(plant_1.reload.waterings.count).to eq(10)
    expect(plant_2.reload.waterings.count).to eq(3)
    expect(Watering.where(water_time: one_week_from_today).count).to eq(1)
    a_day_goes_by([plant_1, plant_2])
    expect(plant_1.reload.waterings.count).to eq(11)
    expect(plant_2.reload.waterings.count).to eq(4)
    expect(Watering.where(water_time: one_week_from_today).count).to eq(2)
  end
end
