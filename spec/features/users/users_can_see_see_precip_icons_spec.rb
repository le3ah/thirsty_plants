require 'rails_helper'

describe "As a user, visiting the site" do
  it "sees icons is accordance with weather conditions", :vcr do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    service = DarkSkyService.new
    lat = "1.43533"
    long = "-0.0004503993"

    weather_info = service.get_weather(lat, long)
    weather_day = weather_info[:daily][:data][0]
    if weather_day[:precipType]
      precip_type = weather_day[:precipType]
    else
      precip_type = "precipitation"
    end

    today = (Time.now).strftime('%A')

    visit gardens_path
    expect(page).to_not have_content("Chance of #{precip_type}")

    visit dashboard_path
    expect(page).to_not have_content("Chance of #{precip_type}")

    garden = create(:garden, user: user)
    plant = create(:plant, garden: garden)

    if weather_day[:precipType].downcase == "snow"
      selector = ".fa-snowflakes"
    elsif weather_day[:precipType].downcase == "sleet"
      selctor = ".fa-cloud-sleet"
    elsif weather_day[:precipType] == nil
      selector = ".fa-raindrops"
    else
      selector = ".fa-raindrops"
    end
    visit dashboard_path

    within ".gardens-container" do
      expect(page).to have_selector(selector)
      expect(page).to have_content("#{today}, Chance of #{precip_type.capitalize}")
    end

    visit gardens_path

    within ".gardens-container" do
      # expect(page).to have_selector(selector)
      # expect(page).to have_content("#{today}, Chance of #{precip_type.capitalize}")
    end
  end
end
