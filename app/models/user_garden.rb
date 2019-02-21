class UserGarden < ApplicationRecord
  belongs_to :user
  belongs_to :garden

  enum relationship_type: ["owner", "caretaker"]
end
