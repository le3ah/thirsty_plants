require 'rails_helper'

describe 'as a logged-in user, I can see the garden index page' do
  it "should see garden details", :vcr do
    user = create(:user)
    user_2 = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    garden_1 = create(:garden, user: user)
    garden_2 = create(:garden, user: user_2)
    garden_3 = create(:garden, user: user)

    visit gardens_path

    within "#garden-#{garden_1.id}" do
      expect(page).to have_content(garden_1.name)
      expect(page).to have_content(garden_1.zip_code)
      expect(page).to have_link("#{garden_1.name}")
    end

    expect(page).to_not have_content(garden_2.name)
    expect(page).to_not have_content(garden_2.zip_code)
    expect(page).to_not have_link("#{garden_2.name}")

    within "#garden-#{garden_3.id}" do
      expect(page).to have_content(garden_3.name)
      expect(page).to have_content(garden_3.zip_code)
      click_on("#{garden_3.name}")
      expect(current_path).to eq(garden_path(garden_3))
    end
  end
  it "sees weather data", :vcr do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    garden = create(:garden, user: user, name: "Backyard", lat: "1.342432", long: "-0.00045580")
    visit gardens_path

    today = Time.now
    within("#garden-#{garden.id}") do
      expect(page).to have_content("Weather in #{garden.name}:")
      expect(page).to have_css('.weather_day', count: 7)
      expect(page).to have_content("#{today.strftime('%A')}")
      expect(page).to have_content("#{(today + 1.days).strftime('%A')}")
      expect(page).to have_content("#{(today + 2.days).strftime('%A')}")
      expect(page).to have_content("#{(today + 3.days).strftime('%A')}")
      expect(page).to have_content("#{(today + 4.days).strftime('%A')}")
      expect(page).to have_content("#{(today + 5.days).strftime('%A')}")
      expect(page).to have_content("#{(today + 6.days).strftime('%A')}")
    end
  end
end
