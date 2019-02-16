class Watering < ApplicationRecord
  belongs_to :plant
  validates_presence_of :water_time

  def css_plant_name_class #would be more at home in a decorator class, though this refactor wouldn't be simple
    "watered-plant-name" if completed?
  end
end
