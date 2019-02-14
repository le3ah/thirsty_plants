require "rails_helper"
describe 'user sees schedule' do
  it 'displays all water_times' do
    garden = create(:garden)
    water_times = create_list(:water_time, 7)

    allow_any_instance_of(ApplicationController).to recieve(:current_user).and_return(garden.user)

    visit(dashboard_path)
    click_link "Watering schedule something"
    expect(page).to have_xpath("/today/a")
  end
end
