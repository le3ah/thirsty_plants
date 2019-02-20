class Garden < ApplicationRecord
  has_many :user_gardens
  has_many :users, through: :user_gardens
  has_many :plants, dependent: :destroy
  validates_presence_of :name, :zip_code
  accepts_nested_attributes_for :plants, reject_if: :all_blank

  before_save :set_lat_long, unless: :has_lat_long?

  def owners=(users)
    users.each do |user|
      UserGarden.create(relationship_type: 0, garden: self, user: user)
    end
  end

  def owners
    User.where(user_gardens: {relationship_type: 0, garden: self}).joins(:user_gardens)
  end

  private

  def has_lat_long?
    self.lat && self.long
  end

  def set_lat_long
    self.lat = ZipcodeFinder.new(self.zip_code).latitude
    self.long = ZipcodeFinder.new(self.zip_code).longitude
  end
end
