require "rails_helper"
describe 'user sees schedule' do
  it 'displays all waterings' do
    plant = create(:plant)
    waterings = create_list(:watering, 7, plant: plant)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(plant.garden.user)

    visit(dashboard_path)
    click_link "View Watering Schedule"
    # expect(page).to have_xpath(/today/)
    watering = waterings.first

    within("##{watering.water_time.strftime('%b%d')}") do
      expect(page).to have_content(watering.water_time.strftime('%b. %d'))
      expect(page).to have_content(watering.plant.name, count: 7)
    end
    expect(page).to have_content(watering.plant.name, count: 7)
    
  end
end
