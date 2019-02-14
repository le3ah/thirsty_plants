require 'rails_helper'

describe WeatherService do
  it 'can get chance of rain' do
    latitude = 39.7518649
    longitude = -105.00402989999999
    service = WeatherService.new(latitude, longitude)
    
    results = service.chance_of_rain
    expect(results[:latitude]).to eq(latitude)
    expect(results[:longitude]).to eq(longitude)
    expect(results).to have_key(:timezone)
    expect(results).to have_key(:currently)
    expect(results).to have_key(:daily)
    expect(results[:daily][:data].first).to have_key(:time)
    expect(results[:daily][:data].first).to have_key(:precipProbability)
  end
end