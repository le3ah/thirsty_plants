require 'rails_helper'

describe DarkSkyService do
  it "can get weather", :vcr do
    service = DarkSkyService.new
    lat = "1.43533"
    long = "-0.0004503993"

    result = service.get_weather(lat, long)

    expect(result[:latitude]).to eq(lat.to_f)
    expect(result[:longitude]).to eq(long.to_f)
    expect(result).to have_key(:daily)
    expect(result[:daily][:data].first).to have_key(:icon)
    expect(result[:daily][:data].first).to have_key(:precipProbability)
  end
end
