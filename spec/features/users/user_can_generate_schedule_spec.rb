require 'rails_helper'

describe 'As a logged in user when visiting my dashboard' do
  it 'sees a link to schedule index page' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    garden_1 = create(:garden, user: user)
    garden_2 = create(:garden, user: user)

    plant_1 = create(:plant, garden: garden_1)
    plant_2 = create(:plant, garden: garden_1)

    plant_3 = create(:plant, garden: garden_2)
    plant_4 = create(:plant, garden: garden_2)

    visit dashboard_path

    click_button("View Watering Schedule")

    expect(current_path).to eq(schedules_path)
  end
end


# On my dashboard, I see a link to generate my watering schedule.
# When I click this button, I am redirected to the schedule index page.
# The index page shows the schedules for each of my gardens.
