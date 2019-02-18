require './lib/modules/our_array_methods'
class Scheduler
  def self.generate_plant_schedule(plant)
    times_each_day(plant).each_with_index do |times_per_day, i|
      times_per_day.times do
        Watering.create(plant: plant, water_time: i.days.from_now.localtime)
      end
    end
  end

  private

  def self.times_each_day(plant)
    OurArrayMethods.spread_evenly(8, (plant.times_per_week.to_f/7))
  end
end
