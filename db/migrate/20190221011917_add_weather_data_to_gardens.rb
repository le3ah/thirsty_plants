class AddWeatherDataToGardens < ActiveRecord::Migration[5.1]
  def change
    add_column :gardens, :weather_data, :string
  end
end
