class Garden < ApplicationRecord
  belongs_to :user
  has_many :plants, dependent: :destroy
  validates_presence_of :name, :zip_code
  accepts_nested_attributes_for :plants, reject_if: :all_blank

  before_save :set_lat_long, unless: :has_lat_long?
  
  private
  
  def has_lat_long?
    self.lat && self.long
  end
  
  def set_lat_long
    self.lat = ZipcodeFinder.new(self.zip_code).latitude
    self.long = ZipcodeFinder.new(self.zip_code).longitude
  end
end
