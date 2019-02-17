class Plant < ApplicationRecord
  belongs_to :garden
  has_many :waterings, dependent: :destroy
  validates_presence_of :name
  validates_presence_of :times_per_week
end
