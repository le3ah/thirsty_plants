require 'rails_helper'

describe 'as an Admin' do
  describe 'when they visit the welcome page' do
    it 'can login as an admin' do
      user = create(:user, google_id: "uidexample", role: 1)
      stub_omniauth

      visit root_path
      click_link "Sign in with Google"
      expect(current_path).to eq(admin_dashboard_path)
      expect(page).to have_content("Welcome, Admin #{user.first_name}")
    end

  end
end
