require 'rails_helper'

describe 'as an Admin' do
  describe 'when they visit their dashboard' do
    it 'shows a list of default app users' do
      admin = create(:user, role: 1)
      user_1 = create(:user)
      user_2 = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path

      expect(page).to have_content("Admin Dashboard")
      expect(page).to have_content(user_1.first_name)
      expect(page).to have_content(user_2.first_name)
      expect(page).to have_content(user_1.created_at.to_date)
      expect(page).to have_content(user_2.created_at.to_date)
    end
  end
end
