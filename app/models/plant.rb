class Plant < ApplicationRecord
  belongs_to :garden
  has_many :waterings, dependent: :destroy
  validates_presence_of :name
  validates_presence_of :times_per_week
  validates_numericality_of :times_per_week,
                            greater_than_or_equal_to: 0, 
                            less_than_or_equal_to: 35
end
