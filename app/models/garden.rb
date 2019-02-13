class Garden < ApplicationRecord
  belongs_to :user
  has_many :plants
  validates_presence_of :name, :zip_code
end
