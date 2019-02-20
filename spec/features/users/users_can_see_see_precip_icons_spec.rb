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
    precip_type = weather_day[:precipType]
    day = Time.now.strftime('%A')

    visit gardens_path
    expect(page).to_not have_content("Chance of #{precip_type}")

    visit dashboard_path
    expect(page).to_not have_content("Chance of #{precip_type}")

    garden = create(:garden, user: user)
    plant = create(:plant, garden: garden)

    visit dashboard_path

    within ".gardens-container" do
      # expect(page).to have_css("img[src*='environ-peeling-kuur.jpg']")
      expect(page).to have_content("#{day}, Chance of #{precip_type.capitalize}")
    end

    visit gardens_path

    within ".gardens-container" do
      # expect(page).to have_image()
      expect(page).to have_content("#{day}, Chance of #{precip_type.capitalize}")
    end
  end
end
