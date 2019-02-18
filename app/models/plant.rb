class Plant < ApplicationRecord
  belongs_to :garden
  has_many :waterings, dependent: :destroy
  validates_presence_of :name
  validates_presence_of :times_per_week
  after_save :generate_waterings

  def generate_waterings
    Scheduler.generate_plant_schedule(self)
  end
end
