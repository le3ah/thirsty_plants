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
      self.lat = LocationService.new.get_latitude(self.zip_code)
      self.long = LocationService.new.get_longitude(self.zip_code)
    else
      return
    end
  end
end
