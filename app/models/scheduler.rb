require './lib/modules/our_array_methods'
class Scheduler
  def self.generate_plant_schedule(plant)
    times_each_day(plant).each_with_index do |times_per_day, i|
      times_per_day.times do
        Watering.create(plant: plant, water_time: Date.parse(i.days.from_now.localtime.to_s))
      end
    end
  end

  def generate_waterings(date)
    Plant.all.each do |plant|
      get_schedule_as_array_from(plant.future_waterings, date)
    end
  end

  private

  def self.times_each_day(plant)
    OurArrayMethods.spread_evenly(8, (plant.times_per_week.to_f/7))
  end

  def get_schedule_as_array_from(plant, date)
    plant.waterings
  end
end
