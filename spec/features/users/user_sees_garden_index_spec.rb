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

    expect(page).to have_content("#PlantLife")
    expect(page).to have_content("#{user.first_name}'s Greenery")

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
  it "sees plant information", :vcr do
    user = create(:user)
    garden = create(:garden, name: "Back Yard", zip_code: 80206, user: user)
    plant_1 = create(:plant, name: "Petunia", times_per_week: 5, garden: garden)
    plant_2 = create(:plant, name: "Sunflower", times_per_week: 3, garden: garden)
    plant_3 = create(:plant, name: "Dahlia", times_per_week: 5, garden: garden)

    garden_2 = create(:garden, name: "Front Yard", zip_code: 80206, user: user)
    plant_4 = create(:plant, name: "Morning Glory", times_per_week: 5, garden: garden_2)
    plant_5 = create(:plant, name: "Rose", times_per_week: 3, garden: garden_2)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit gardens_path

    save_and_open_page

    within "#garden-#{garden.id}" do
      expect(page).to have_content("All the plants in #{garden.name}")

      expect(page).to have_content(plant_1.name)
      expect(page).to have_content("Watering Requirements: #{plant_1.times_per_week.round(0)} times/week")
    end
    within "#garden-#{garden_2.id}" do
      expect(page).to have_content("All the plants in #{garden_2.name}")

      expect(page).to have_content(plant_4.name)
      expect(page).to have_content("Watering Requirements: #{plant_4.times_per_week.round(0)} times/week")
    end
  end
end
