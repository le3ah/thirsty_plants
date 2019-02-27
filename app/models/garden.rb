class Garden < ApplicationRecord
  has_many :user_gardens, dependent: :destroy
  has_many :users, through: :user_gardens
  has_many :plants, dependent: :destroy
  validates_presence_of :name, :zip_code
  accepts_nested_attributes_for :plants, reject_if: :all_blank

  before_save :set_lat_long, unless: :has_lat_long?

  def owners=(users)
    users.each do |user|
      UserGarden.create(relationship_type: 'owner', garden: self, user: user)
    end
  end

  def owners
    User.where(user_gardens: {relationship_type: 'owner', garden: self}).joins(:user_gardens)
  end

  def caretakers=(users)
    users.each do |user|
      UserGarden.create(relationship_type: 'caretaker', garden: self, user: user)
    end
  end

  def caretakers
    User.where(user_gardens: {relationship_type: 'caretaker', garden: self}).joins(:user_gardens)
  end

  def waterings_for_user_for_day(day)
    Watering.join
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
