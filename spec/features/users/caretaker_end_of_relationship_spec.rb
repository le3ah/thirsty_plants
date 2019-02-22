require "rails_helper"

describe 'end of caretaker relationship', :vcr do
  before(:each) do
    @user_1 = create(:garden).owners.first
    @caretaker_1 = create(:user)
    @garden_1 = @user_1.gardens.first
    @user_garden = create(:user_garden, user: @caretaker_1, garden: @garden_1, relationship_type: "caretaker")
  end
  scenario 'as a caretaker I can cancel' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@caretaker_1.reload)
    visit gardens_path

    within "#garden-#{@garden_1.id}" do
      within ".cancel-caretaking-button" do
        click_on "Stop taking care of #{@garden_1.name}"
      end
    end
    expect(current_path).to eq(gardens_path)
    expect(page).to have_content("You are no longer taking care of #{@garden_1.name}")
    expect(page).to_not have_css("#garden-#{@garden_1.id}")
  end
  scenario 'as an owner I can cancel' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1.reload)
    visit gardens_path
    within "#garden-#{@garden_1.id}" do
      within "#caretaker-relationship-#{@caretaker_1.id}" do
        expect(page).to have_content("#{@caretaker_1.first_name} is taking care of this garden")
        within ".cancel-caretaking-button" do
          click_on "Cancel Caretaking"
        end
      end
    end
    expect(current_path).to eq(gardens_path)
    expect(page).to have_content("#{@caretaker_1.first_name} is no longer taking care of #{@garden_1.name}")
    within "#garden-#{@garden_1.id}" do
      expect(page).to_not have_css("#caretaker-relationship-#{@user_garden.id}")
    end
  end
end
