require 'rails_helper'

describe 'as a logged in user' do
  it 'shows a button to add a caretaker to a garden on the gardens index', :vcr do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    garden_1 = create(:garden, owners: [user], name: "Frontyard")
    garden_2 = create(:garden, owners: [user], name: "Backyard")

    visit gardens_path

    within "#garden-#{garden_1.id}" do
      expect(page).to have_link("Add Caretaker for this Garden")
      click_link "Add Caretaker for this Garden"
      expect(current_path).to eq(invite_path(garden_1))
    end
  end

  it 'can send an invitation to become a caretaker', :vcr do
    user_1 = create(:user)
    user_2 = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    garden_1 = create(:garden, owners: [user_1], name: "Frontyard")
    clear_emails

    visit gardens_path

    click_link "Add Caretaker"
    email = "a@gmail.com"
    fill_in :email, with: email
    click_on "Send Email Invitation"

    expect(page).to have_content("Success! You invited a caretaker to watch your gardens.")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_2)

    open_email(email)
    expect(current_email).to have_link("Register or sign in", href: signin_url)
    current_email.click_link("Take care of #{garden_1.name.capitalize}")
    expect(current_path).to eq(garden_path(garden_1))
    expect(page).to have_content("Welcome to your friend's garden!")
  end


end
