require 'rails_helper'

describe 'as a logged in user' do
  it 'shows a button to add a caretaker to a garden on the gardens index', :vcr do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    garden_1 = create(:garden, owners: [user], name: "Frontyard")
    garden_2 = create(:garden, owners: [user], name: "Backyard")

    visit gardens_path

    within "#garden-#{garden_1.id}" do
      expect(page).to have_link("Add Caretaker")
      click_link "Add Caretaker"
      expect(current_path).to eq(invite_path)
    end
  end

  it 'can send an invitation to become a caretaker', :vcr do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    garden_1 = create(:garden, owners: [user], name: "Frontyard")

    visit gardens_path

    click_link "Add Caretaker"
    fill_in :email, with: "ali.benetka@gmail.com"
    click_on "Send Email Invitation"

    expect(page).to have_content("Success! You invited a caretaker to watch your gardens.")
  end


end
