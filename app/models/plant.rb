class Plant < ApplicationRecord
  belongs_to :garden
  has_many :waterings, dependent: :destroy
  validates_presence_of :name
  validates_presence_of :times_per_week
  validates_numericality_of :times_per_week,
                            greater_than_or_equal_to: 0,
                            less_than_or_equal_to: 35
  after_create :generate_waterings

  def generate_waterings
    clear_future_waterings
    Scheduler.generate_plant_schedule(self)
  end

  def  waterings_from_now_until(date)
    waterings.where(water_time: Date.today.. (date))
  end

  def projected_thirstiness_of_plant_on(date)
    watering_count = waterings_from_now_until(date).size
    days_included = (date - Date.today + 1).to_i
    days_included * times_per_day - watering_count
  end

  def times_per_day
    (times_per_week.to_f / 7)
  end



  private

  def clear_future_waterings
    future_waterings = waterings.where("water_time >= ?", Time.now)
    Watering.delete(future_waterings)
  end
end
