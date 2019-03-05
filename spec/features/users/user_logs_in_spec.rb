require "rails_helper"

describe 'subject' do
  describe 'as a visitor' do
    it "should click sign in and be logged in with google oauth", :vcr do
      user = create(:user, google_id: "uidexample")
      garden = create(:garden, owners: [user])
      stub_omniauth

      visit root_path
      click_link "Sign in with Google"
      expect(page).to have_content(garden.name)
    end

  end
  describe 'as a logged in user' do
    it 'when I navigate to the root path I am redirected to my dashboard and not a link to log in' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit root_path
      expect(current_path).to eq(dashboard_path)
    end
  end
end
