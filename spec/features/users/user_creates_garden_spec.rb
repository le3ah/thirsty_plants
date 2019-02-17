require 'rails_helper'

describe 'As a logged in user on the site' do
  it 'Can see a new garden form', :vcr do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    click_button 'Create New Garden'

    expect(current_path).to eq(new_garden_path)
    expect(page).to have_field("Garden Name")
    expect(page).to have_field("Zip code")
    expect(page).to have_field("Plant Name")
    expect(page).to have_field("Plant Watering Requirements")
  end

  it 'Can create a garden', :vcr do
    user = create(:user)
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
    within ".plants-container" do
      expect(page).to have_content("Roses")
      expect(page).to have_content("Watering Requirements: 3 times/week")
      expect(page).to have_content("Sunflowers")
      expect(page).to have_content("Watering Requirements: 2 times/week")
      expect(page).to have_content("My Plant: Fuzzy")
      expect(page).to have_content("Watering Requirements: 5 times/week")
    end
  end

  it 'Cannot create a garden with incomplete information', :vcr do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit new_garden_path
    click_button "Create Garden"

    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Zip code can't be blank")
    expect(page).to have_content("Create a New Garden")
  end
  
  it 'Can create a garden with no plants', :vcr do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit new_garden_path

    fill_in :garden_name, with: "My Garden"
    fill_in :garden_zip_code, with: "80203"
    click_button "Create Garden"

    garden = Garden.last
    expect(current_path).to eq(garden_path(garden))
    expect(page).to have_content(garden.name)
    expect(page).to have_content(garden.zip_code)
  end

  it 'creates a garden and the zip code is converted to lat/long', :vcr do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit new_garden_path
    fill_in :garden_name, with: "My Garden"
    fill_in :garden_zip_code, with: "80203"
    click_button "Create Garden"

    garden = Garden.last

    expect(garden.lat).to eq('39.7312095')
    expect(garden.long).to eq('-104.9826965')
    expect(garden.zip_code).to eq('80203')
  end
end
