require 'rails_helper'

describe "As a user, visiting the site" do
  it "sees icons in accordance with weather conditions - for snow" do
    day_index = 0
    today = (Time.now).strftime('%A')
    lat = "123.00005"
    long = "-0.123496"
    weather_info =   {"daily" => {
        "summary" => "Mixed precipitation today through Sunday, with high temperatures rising to 53°F on Sunday.",
        "icon" => "snow",
        "data" => [
            {
                "time" => 1550638800,
                "summary" => "Heavy snow (2–5 in.) starting in the evening.",
                "icon" => "snow",
                "precipIntensity" => 0.0038,
                "precipProbability" => 12.0,
                "precipAccumulation" => 0.993,
                "precipType" => "snow"
            }] }}

    garden = create(:garden, lat: lat, long: long)
    plant = create(:plant, garden: garden)

    weather = Weather.new(garden)
    allow(weather).to receive(:weather_info).and_return(weather_info)
    precip_type = weather.precip_type(day_index).capitalize
    precip_icon = weather.precip_icon(day_index)
    expect(precip_type).to eq("Snow")

    expect(precip_type).to eq("Snow")
    expect(precip_icon).to eq("far fa-snowflake")
  end

  it "sees icons in accordance with weather conditions - for sleet > 10%" do
    day_index = 0
    today = (Time.now).strftime('%A')
    lat = "123.00005"
    long = "-0.123496"
    weather_info =   {"daily" => {
        "summary" => "Mixed precipitation today through Sunday, with high temperatures rising to 53°F on Sunday.",
        "icon" => "sleet",
        "data" => [
            {
                "time" => 1550638800,
                "summary" => "Heavy snow (2–5 in.) starting in the evening.",
                "icon" => "sleet",
                "precipIntensity" => 0.0038,
                "precipProbability" => 0.110,
                "precipAccumulation" => 0.993,
                "precipType" => "sleet"
            }] }}

    garden = create(:garden, lat: lat, long: long)
    plant = create(:plant, garden: garden)

    weather = Weather.new(garden)
    allow(weather).to receive(:weather_info).and_return(weather_info)
    precip_type = weather.precip_type(day_index).capitalize
    precip_icon = weather.precip_icon(day_index)

    expect(precip_type).to eq("Sleet")
    expect(precip_icon).to eq('fas fa-cloud-showers-heavy')
  end

  it "sees icons in accordance with weather conditions - for rain > 10%" do
    day_index = 0
    today = (Time.now).strftime('%A')
    lat = "123.00005"
    long = "-0.123496"
    weather_info =   {"daily" => {
        "summary" => "Mixed precipitation today through Sunday, with high temperatures rising to 53°F on Sunday.",
        "icon" => "rain",
        "data" => [
            {
                "time" => 1550638800,
                "summary" => "Heavy snow (2–5 in.) starting in the evening.",
                "icon" => "rain",
                "precipIntensity" => 0.0038,
                "precipProbability" => 0.120,
                "precipAccumulation" => 0.993,
                "precipType" => "rain"
            }] }}

    garden = create(:garden, lat: lat, long: long)
    plant = create(:plant, garden: garden)

    weather = Weather.new(garden)
    allow(weather).to receive(:weather_info).and_return(weather_info)
    precip_type = weather.precip_type(day_index).capitalize
    precip_icon = weather.precip_icon(day_index)

    expect(precip_type).to eq("Rain")
    expect(precip_icon).to eq('fas fa-cloud-rain')
  end

  it "does not see icon in accordance with weather conditions - for nil < 10%" do
    day_index = 0
    today = (Time.now).strftime('%A')
    lat = "123.00005"
    long = "-0.123496"
    weather_info =   {"daily" => {
        "summary" => "Mixed precipitation today through Sunday, with high temperatures rising to 53°F on Sunday.",
        "icon" => "rain",
        "data" => [
            {
                "time" => 1550638800,
                "summary" => "Heavy snow (2–5 in.) starting in the evening.",
                "precipIntensity" => 0.0038,
                "precipProbability" => 0.09,
                "precipAccumulation" => 0.993,
            }] }}

    garden = create(:garden, lat: lat, long: long)
    plant = create(:plant, garden: garden)

    weather = Weather.new(garden)
    allow(weather).to receive(:weather_info).and_return(weather_info)
    precip_type = weather.precip_type(day_index).capitalize
    precip_icon = weather.precip_icon(day_index)

    expect(precip_type).to eq("Precipitation")
    expect(precip_icon).to eq('')
  end

  it "sees icons is accordance with weather conditions - rain < 10%" do
    day_index = 0
    today = (Time.now).strftime('%A')
    lat = "123.00005"
    long = "-0.123496"
    weather_info =   {"daily" => {
        "summary" => "Mixed precipitation today through Sunday, with high temperatures rising to 53°F on Sunday.",
        "icon" => "rain",
        "data" => [
            {
                "time" => 1550638800,
                "summary" => "Heavy snow (2–5 in.) starting in the evening.",
                "icon" => "rain",
                "precipIntensity" => 0.0038,
                "precipProbability" => 0.01,
                "precipAccumulation" => 0.993,
                "precipType" => "rain"
            }] }}

    garden = create(:garden, lat: lat, long: long)
    plant = create(:plant, garden: garden)

    weather = Weather.new(garden)
    allow(weather).to receive(:weather_info).and_return(weather_info)
    precip_type = weather.precip_type(day_index).capitalize
    precip_icon = weather.precip_icon(day_index)

    expect(precip_type).to eq("Rain")
    expect(precip_icon).to eq('')
  end
  it "sees icons is accordance with weather conditions - nil > 10%" do
    day_index = 0
    today = (Time.now).strftime('%A')
    lat = "123.00005"
    long = "-0.123496"
    weather_info =   {"daily" => {
        "summary" => "Mixed precipitation today through Sunday, with high temperatures rising to 53°F on Sunday.",
        "icon" => "rain",
        "data" => [
            {
                "time" => 1550638800,
                "summary" => "Heavy snow (2–5 in.) starting in the evening.",
                "icon" => "rain",
                "precipIntensity" => 0.0038,
                "precipProbability" => 0.21,
                "precipAccumulation" => 0.993,
                "precipType" => nil
            }] }}

    garden = create(:garden, lat: lat, long: long)
    plant = create(:plant, garden: garden)

    weather = Weather.new(garden)
    allow(weather).to receive(:weather_info).and_return(weather_info)
    precip_type = weather.precip_type(day_index).capitalize
    precip_icon = weather.precip_icon(day_index)

    expect(precip_type).to eq("Precipitation")
    expect(precip_icon).to eq('fas fa-cloud-rain')
  end
end
