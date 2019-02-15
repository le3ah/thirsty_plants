class Watering < ApplicationRecord
  belongs_to :plant
  validates_presence_of :water_time
end
