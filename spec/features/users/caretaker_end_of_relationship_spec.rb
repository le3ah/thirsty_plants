require "rails_helper"

describe 'end of caretaker relationship' do
  before(:each) do
    @user_1 = create(:garden).owners.first
    @caretaker_1 = create(:user)
    @garden_1 = @user_1.gardens.first
    create(:user_garden, user: @caretaker_1, garden: @garden_1)
  end
  scenario 'as a caretaker I can cancel' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@caretaker_1.reload)
    visit gardens_path
    within "#garden-#{@garden_1.id}" do
      click_on "Stop taking care of #{@garden_1.name}"
    end
    expect(current_path).to eq(gardens_path)
    expect(page).to have_content("You are no longer taking care of #{@garden_1.name}")
    expect(page).to_not have_css("#garden-#{@garden_1.id}")
  end
end
