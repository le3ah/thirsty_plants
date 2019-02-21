require 'rails_helper'

describe "As a user, visiting the site" do
  it "sees icons is accordance with weather conditions" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    day_index = 0
    today = (Time.now).strftime('%A')
    lat = "123.00005"
    long = "-0.123496"
    weather_info =   {"daily": {
        "summary": "Mixed precipitation today through Sunday, with high temperatures rising to 53°F on Sunday.",
        "icon": "snow",
        "data": [
            {
                "time": 1550638800,
                "summary": "Heavy snow (2–5 in.) starting in the evening.",
                "icon": "snow",
                "precipIntensity": 0.0038,
                "precipProbability": 0.43,
                "precipAccumulation": 0.993,
                "precipType": "snow"
            }] }}

    weather = Weather.new(lat, long)
    allow(weather).to receive(:weather_info).and_return(weather_info)
    precip_type = weather.precip_type(day_index).capitalize
    precip_icon = weather.precip_icon(day_index)
    expect(precip_type).to eq("Snow")

    visit gardens_path
    expect(page).to_not have_content("Chance of #{precip_type}")

    visit dashboard_path
    expect(page).to_not have_content("Chance of #{precip_type}")

    garden = create(:garden, user: user)
    plant = create(:plant, garden: garden)

    expect(precip_type).to eq("Snow")
    expect(precip_icon).to eq("far fa-snowflake")
  end
end
