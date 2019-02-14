require "rails_helper"
describe 'user sees schedule' do
  it 'displays all waterings' do
    plant = create(:plant)
    plant_2 = create(:plant, garden: plant.garden)
    waterings = create_list(:watering, 2, plant: plant)
    waterings = create_list(:watering, 1, plant: plant_2)
    waterings = create_list(:watering, 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(plant.garden.user)

    visit(dashboard_path)
    click_link "View Watering Schedule"
    # expect(page).to have_xpath(/today/)
    watering = waterings.first
    save_and_open_page
    within("##{watering.water_time.strftime('%b%d')}") do
      expect(page).to have_content(watering.water_time.strftime('%b. %d'))
      expect(page).to have_content(plant.name, count: 2)
      expect(page).to have_content(plant_2.name, count: 1)
    end
    expect(page).to have_content(watering.plant.name, count: 2)

  end
end
