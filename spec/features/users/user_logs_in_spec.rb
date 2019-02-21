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
end
