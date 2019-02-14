require 'rails_helper'

describe DarkSkyService do
  it "can get chance of rain" do
    service = DarkSkyService.new
    lat = "1.43533000"
    long = "-0.0004503993"

    result = service.chance_of_rain(lat, long)

    expect(result[:latitude]).to eq(lat)
    expect(result[:longitude]).to eq(long)
    expect(result).to have_key(:daily)
    expect(result[:daily][:data].first).to have_key(:icon)
    expect(result[:daily][:data].first).to have_key(:precipProbability)
  end
end
