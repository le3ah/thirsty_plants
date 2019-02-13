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
  end

  it 'Can add plants on the new garden form' do
    user = User.create(name: "User1", email: "user@example.com")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit new_garden_path
    expect(page).to have_field("Plant Name")
    expect(page).to have_field("Plant Watering Requirements")
  end
end
