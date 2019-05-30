class Plant < ApplicationRecord
  belongs_to :garden
  has_many :waterings, dependent: :destroy
  validates_presence_of :name
  validates_presence_of :times_per_week
  validates_numericality_of :times_per_week,
                            greater_than_or_equal_to: 0,
                            less_than_or_equal_to: 35
  after_create :generate_waterings

  has_attached_file :thumbnail, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  },
  default_url: ':style/default.png'

  validates_attachment_content_type :thumbnail, :content_type => /\Aimage\/.*\Z/
  def generate_waterings
    clear_future_waterings
    Scheduler.generate_plant_schedule(self)
  end

  def  waterings_from_now_until(date)
    waterings.where(water_time: Time.now.to_date.. (date))
  end

  def projected_thirstiness_of_plant_on(date)
    watering_count = waterings_from_now_until(date).size
    days_included = (date - Time.now.to_date + 1).to_i
    days_included * times_per_day - watering_count
  end

  def times_per_day
    (times_per_week.to_f / 7)
  end

  def watering_days
    waterings.map do |watering|
      watering.water_time.strftime('%A')
    end.join(', ')
  end

  def todays_waterings
    waterings.where(water_time: Date.today.beginning_of_day..  Date.today.end_of_day)
  end

  private

  def clear_future_waterings
    future_waterings = waterings.where("water_time >= ?", Time.now)
    Watering.delete(future_waterings)
  end
end
