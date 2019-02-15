class Zipcode < ApplicationRecord
  validates_presence_of :zip_code, :latitude, :longitude
end
