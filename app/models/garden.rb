class Garden < ApplicationRecord
  belongs_to :user
  has_many :plants, dependent: :destroy
  validates_presence_of :name, :zip_code
  accepts_nested_attributes_for :plants, reject_if: :all_blank

  before_save :set_lat_long
  
  private
  
  def set_lat_long
    if self.lat && self.long
      return
    elsif self.zip_code != ''
      self.lat = LocationService.new(self.zip_code).get_latitude
      self.long = LocationService.new(self.zip_code).get_longitude
    else
      return
    end
  end
end
