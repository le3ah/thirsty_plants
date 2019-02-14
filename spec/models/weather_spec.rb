require 'rails_helper'

describe Weather do
  it "exists" do
    index = 0
    lat = "123.00005"
    long = "-0.123496"
    weather = Weather.new(lat, long)

    expect(weather).to be_a(Weather)
  end
  it "has attributes" do
    lat = "123.00005"
    long = "-0.123496"
    index = 0

    weather = Weather.new(lat, long)
    expect(weather.lat).to eq("123.00005")
    expect(weather.long).to eq("-0.123496")
  end
end
