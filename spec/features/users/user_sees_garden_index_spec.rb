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
end
