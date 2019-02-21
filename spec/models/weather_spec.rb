require 'rails_helper'

describe Weather do
  it "exists" do
    garden = create(:garden)
    weather = Weather.new(garden)

    expect(weather).to be_a(Weather)
  end
  it "has attributes" do
    garden = create(:garden)

    weather = Weather.new(garden)
    expect(weather.garden).to eq(garden)
    expect(weather.lat).to eq(garden.lat)
    expect(weather.long).to eq(garden.long)
  end
  it "can return the chance of rain" do
    day_index = 0
    lat = "123.00005"
    long = "-0.123496"
    garden = create(:garden, lat: lat, long: long)
    weather_info = {"daily" => {
      "summary": "Rain today through Saturday, with high temperatures falling to 49°F on Sunday.",
      "icon": "rain",
      "data" => [
        {
          "time": 1550131200,
          "summary": "Rain until afternoon, starting again in the evening, and breezy starting in the afternoon.",
          "icon": "rain",
          "sunriseTime": 1550156511,
          "sunsetTime": 1550195319,
          "moonPhase": 0.32,
          "precipIntensity": 0.061,
          "precipIntensityMax": 0.2176,
          "precipIntensityMaxTime": 1550138400,
          "precipProbability" => 0.28}
        ]
      }
    }

    weather = Weather.new(garden)
    allow(weather).to receive(:weather_info).and_return(weather_info)
    expect(weather.chance_of_rain(day_index).round(0)).to eq(28)
  end
  
  it 'can update all garden weather data' do
    lat = "123.00005"
    long = "-0.123496"
    garden = create(:garden, lat: lat, long: long)
    garden_2 = create(:garden, lat: lat, long: long)
    weather_info = {"daily" => {
      "summary" => "Rain today through Saturday, with high temperatures falling to 49°F on Sunday.",
      "icon" => "rain",
      "data" => [
        {
          "time" => 1550131200,
          "summary" => "Rain until afternoon, starting again in the evening, and breezy starting in the afternoon.",
          "icon" => "rain",
          "sunriseTime" => 1550156511,
          "sunsetTime" => 1550195319,
          "moonPhase" => 0.32,
          "precipIntensity" => 0.061,
          "precipIntensityMax" => 0.2176,
          "precipIntensityMaxTime" => 1550138400,
          "precipProbability" => 0.28}
        ]
      }
    }
    
    allow_any_instance_of(DarkSkyService).to receive(:get_weather).and_return(weather_info)
    
    expect(garden.weather_data).to eq(nil)
    expect(garden_2.weather_data).to eq(nil)
    Weather.get_all_weather_data
    
    expect(garden.reload.weather_data).to eq(weather_info)
    expect(garden_2.reload.weather_data).to eq(weather_info)
  end
end
