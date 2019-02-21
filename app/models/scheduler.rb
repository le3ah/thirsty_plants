require './lib/modules/our_array_methods'
class Scheduler
  def self.generate_plant_schedule(plant)
    times_each_day(plant).each_with_index do |times_per_day, i|
      times_per_day.times do
        Watering.create(plant: plant, water_time: Date.parse(i.days.from_now.localtime.to_s))
      end
    end
  end

  def self.generate_waterings_for_a_week_from_today
    a_week_from_today = Date.today + 7.days
    Plant.all.each do |plant|
      i = plant.projected_thirstiness_of_plant_on(a_week_from_today).to_i
      i.times do
        plant.waterings.create!(water_time: a_week_from_today)
      end
    end
  end

  private

  def self.times_each_day(plant)
    OurArrayMethods.spread_evenly(8, (plant.times_per_week.to_f/7))
  end

  def self.num_needed_by(plant)
    (plant.times_per_week - plant.next_weeks_waterings.size).to_i
  end
end
