class AddLatLongToGarden < ActiveRecord::Migration[5.1]
  def change
    add_column :gardens, :lat, :string
    add_column :gardens, :long, :string
  end
end
