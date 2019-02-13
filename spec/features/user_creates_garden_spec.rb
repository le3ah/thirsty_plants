require 'rails_helper'

describe 'As a logged in user on the site' do
  it 'Can see a new garden form' do
    user = User.create(name: "User1", email: "user@example.com")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path
    click_on 'Create Garden'

    expect(current_path).to eq(new_garden_path)
    expect(page).to have_field("Garden Name")
    expect(page).to have_field("Zip code")
    expect(page).to have_field("Plant Name")
    expect(page).to have_field("Plant Watering Requirements")
  end

  it 'Can create a garden' do
    user = User.create(name: "User1", email: "user@example.com")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit new_garden_path

    fill_in :garden_name, with: "My Garden"
    fill_in :garden_zip_code, with: "80203"

    fill_in :garden_plants_attributes_0_name, with: "My Plant: Fuzzy"
    fill_in :garden_plants_attributes_0_times_per_week, with: 5

    fill_in :garden_plants_attributes_1_name, with: "Roses"
    fill_in :garden_plants_attributes_1_times_per_week, with: 3

    fill_in :garden_plants_attributes_2_name, with: "Sunflowers"
    fill_in :garden_plants_attributes_2_times_per_week, with: 2

    click_button "Create Garden"
    garden = Garden.last

    expect(current_path).to eq(garden_path(garden))
    expect(page).to have_content(garden.name)
    expect(page).to have_content(garden.zip_code)
    within ".plants" do
      expect(page).to have_content("Roses")
      expect(page).to have_content("Watering Requirements: 3 times/week")
      expect(page).to have_content("Sunflowers")
      expect(page).to have_content("Watering Requirements: 2 times/week")
      expect(page).to have_content("My Plant: Fuzzy")
      expect(page).to have_content("Watering Requirements: 5 times/week")
    end
  end
end
