require 'rails_helper'

describe WeatherService do
  it 'can get chance of rain for today' do
    location = {latitude: 39.7518649, longitude: -105.00402989999999}
    service = WeatherService.new(location)
    
    results = service.chance_of_rain
    expect(results[:latitude]).to eq(location[:latitude])
    expect(results[:longitude]).to eq(location[:longitude])
    expect(results).to have_key(:timezone)
    expect(results).to have_key(:currently)
    expect(results).to have_key(:daily)
    expect(results[:daily][:data].first).to have_key(:time)
    expect(results[:daily][:data].first).to have_key(:precipProbability)
  end
end