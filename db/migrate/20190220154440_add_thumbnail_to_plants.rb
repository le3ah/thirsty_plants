class AddThumbnailToPlants < ActiveRecord::Migration[5.1]
  def change
    add_attachment :plants, :thumbnail
  end

  def self.up
    add_attachment :plants, :thumbnail
  end

  def self.down
    remove_attachment :plants, :thumbnail
  end
end
