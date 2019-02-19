class AddThumbnailToPlants < ActiveRecord::Migration[5.1]
  def change
    add_column :plants, :thumbnail, :string, default: "no_img.png"
  end
end
