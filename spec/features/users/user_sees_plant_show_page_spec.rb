require 'rails_helper'

describe  'as a logged-in user' do
  it "can see plant show page from the garden show page" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    garden = create(:garden, owners: [user])
    plant = create(:plant, garden: garden)

    visit garden_path(garden)

    click_on "#{plant.name}"

    expect(current_path).to eq(plant_path(plant))
    expect(page).to have_content(plant.name)
    expect(page).to have_content("#{plant.times_per_week} times per week")
    expect(page).to have_content("within #{plant.garden.name}")
    within('#edit-button') do
      click_on 'Edit My Plant'
    end
    expect(current_path).to eq(edit_plant_path(plant))
  end
  it "can see plant show page from the garden show page", :vcr do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    garden = create(:garden, owners: [user])
    plant = create(:plant, garden: garden)

    visit gardens_path

    click_link "#{plant.name}"

    expect(current_path).to eq(plant_path(plant))
    expect(page).to have_content(plant.name)
    expect(page).to have_content(plant.name)
    expect(page).to have_content("within #{plant.garden.name}")
    expect(page).to have_content("#{plant.times_per_week} times per week")
  end
end
