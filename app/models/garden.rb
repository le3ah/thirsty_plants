class Garden < ApplicationRecord
  belongs_to :user
  validates_presence_of :name, :zip_code
end
