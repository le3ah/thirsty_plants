class Watering < ApplicationRecord
  belongs_to :plant
  validates_presence_of :water_time

  def plant_name_css_class #would be more at home in a decorator class, though this refactor wouldn't be simple
    "watered-plant-name" if completed?
  end

  def plant_image_css_class
    completed? ? "watered-plant-image" : "unwatered-plant-image"
  end
end
