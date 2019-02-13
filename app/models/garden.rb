class Garden < ApplicationRecord
  belongs_to :user
  has_many :plants
  validates_presence_of :name, :zip_code
  accepts_nested_attributes_for :plants
end
