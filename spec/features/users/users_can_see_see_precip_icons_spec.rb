require 'rails_helper'

describe "As a user, visiting the site" do
  it "sees icons is accordance with weather conditions" do
    day_index = 0
    lat = "123.00005"
    long = "-0.123496"
    weather_info = {"daily": {
        "summary": "Rain today through Saturday, with high temperatures falling to 49°F on Sunday.",
        "icon": "rain",
        "data": [
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
                "precipProbability": 0.28}
              ]
            }}

    weather = Weather.new(lat, long)
    weather.stub(:weather_info).and_return(weather_info)

    date = "Monday"
    visit dashboard_path

    within ".weather_day#{date}" do
      expect(page).to have_image()
      expect(page).to have_content("Chance of rain")
    end

    visit gardens_path

    within ".weather_day#{date}" do
      expect(page).to have_image()
      expect(page).to have_content("Chance of rain")
    end
  end
end
