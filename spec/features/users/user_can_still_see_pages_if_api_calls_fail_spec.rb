require 'rails_helper'

describe 'As a logged in user of the site' do
  describe 'on the dashboard' do
    it 'can see the site even if API calls fail' do
      user = create(:user)
      garden = create(:garden, user: user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow_any_instance_of(DarkSkyService).to receive(:get_weather).and_return(nil)
      
      visit dashboard_path
      
      expect(page).to_not have_content('Weather')
      expect(page).to_not have_css('weather_day')
      expect(page).to have_content(garden.name)
    end
  end
end