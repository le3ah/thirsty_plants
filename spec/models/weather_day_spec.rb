require 'rails_helper'

describe WeatherDay do
  it 'exists and has attributes' do
    attributes = {
                "time": 1550041200,
                "summary": "Partly cloudy throughout the day.",
                "icon": "partly-cloudy-day",
                "sunriseTime": 1550066177,
                "sunsetTime": 1550104495,
                "moonPhase": 0.29,
                "precipIntensity": 0,
                "precipIntensityMax": 0.0002,
                "precipIntensityMaxTime": 1550113200,
                "precipProbability": 0,
                "temperatureHigh": 60.93
            }
    weather_day = WeatherDay.new(attributes)
    
    expect(weather_day).to be_a(WeatherDay)
    expect(weather_day.time).to eq(attributes[:time])
    expect(weather_day.precip_probability).to eq(attributes[:precipProbability])
  end
end