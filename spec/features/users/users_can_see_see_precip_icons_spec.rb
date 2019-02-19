require 'rails_helper'

describe "As a user, visiting the site" do
  it "sees icons is accordance with weather conditions", :vcr do
    service = DarkSkyService.new
    lat = "1.43533"
    long = "-0.0004503993"

    weather_info = service.get_weather(lat, long)
    weather_day = weather_info[:daily][:data][0]
    precip_type = weather_day[:precipType]
    day = Time.now.strftime('%A')

    visit dashboard_path

    within ".weather_day#{day}" do
      expect(page).to have_css("img[src*='environ-peeling-kuur.jpg']")
      expect(page).to have_content("Chance of #{precip_type}")
    end

    visit gardens_path

    within ".weather_day#{day}" do
      expect(page).to have_image()
      expect(page).to have_content("Chance of #{precip_type}")
    end
  end
end
