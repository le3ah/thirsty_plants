require './lib/modules/our_array_methods'
class Scheduler
  def initialize(user)
    @user = user
  end

  def generate_schedule
    @user.gardens.each do |garden|
      garden.plants.each do |plant|
        self.class.generate_plant_schedule(plant)
      end
    end
  end

  def self.generate_plant_schedule(plant)
    clear_schedule(plant)
    times_each_day(plant).each_with_index do |times_per_day, i|
      times_per_day.times do
        Watering.create(plant: plant, water_time: i.days.from_now)
      end
    end
  end


  private


  def self.clear_schedule(plant)
    plant.waterings.destroy_all
  end

  def self.times_each_day(plant)
    OurArrayMethods.spread_evenly(8, (plant.times_per_week.to_f/7))
  end
end
