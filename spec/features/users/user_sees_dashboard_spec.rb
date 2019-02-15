require 'rails_helper'

describe 'As a logged-in user, I see the dashboard' do
  it 'no gardens created' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Garden Dashboard")
    expect(page).to have_button("Create Garden")
    expect(user.gardens.count).to eq(0)
    expect(page).to have_content("No Gardens Created Yet!")
  end

  it 'gardens created' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    garden_1 = create(:garden, user: user)
    garden_2 = create(:garden, user: user)
    garden_3 = create(:garden, user: user)

    visit dashboard_path

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Garden Dashboard")
    expect(page).to have_button("Create Garden")
    expect(user.gardens.count).to eq(3)

    within "#garden-#{garden_1.id}" do
      expect(page).to have_content(garden_1.name)
      expect(page).to have_content(garden_1.zip_code)
      expect(page).to have_link("#{garden_1.name}")
    end

    within "#garden-#{garden_2.id}" do
      expect(page).to have_content(garden_2.name)
      expect(page).to have_content(garden_2.zip_code)
      click_on("#{garden_2.name}")
      expect(current_path).to eq(garden_path(garden_2))
    end
  end
end
