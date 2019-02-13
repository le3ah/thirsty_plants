class Garden < ApplicationRecord
  belongs_to :user
  has_many :plants, dependent: :destroy
  validates_presence_of :name, :zip_code
  accepts_nested_attributes_for :plants, reject_if: :all_blank
end
