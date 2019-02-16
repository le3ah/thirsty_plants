require 'rails_helper'

describe 'As a logged in user with a garden' do
  it "can delete a garden", :vcr do
    user = create(:user)
    garden_1 = create(:garden, user: user, name: "Frontyard")
    garden_2 = create(:garden, user: user, name: "Backyard")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    
    visit dashboard_path
    expect(page).to have_content garden_1.name
    expect(page).to have_content garden_2.name

    visit garden_path(garden_1)

    click_on 'Delete Garden'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Garden successfully deleted")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user.reload)

    visit dashboard_path

    expect(page).to_not have_content(garden_1.name)
    expect(page).to have_content(garden_2.name)
  end
end
