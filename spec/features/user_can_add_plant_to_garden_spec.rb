require 'rails_helper'

describe 'As a logged in user to the site' do
  describe 'on a garden show page' do
    it 'can add a new plant to their garden' do
      user = create(:user)
      garden = create(:garden, user: user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      
      visit garden_path(garden)
      
      click_on 'Add a Plant to Your Garden!'
      
      expect(current_path).to eq(new_garden_plant_path(garden))
      fill_in :plant_name, with: 'Roses'
      fill_in :plant_times_per_week, with: 5
      click_button 'Create Plant'
      
      expect(current_path).to eq(garden_path(garden))
      expect(page).to have_content("Party in my plants, you've created a new plant!")
      within '.plants' do
        expect(page).to have_content('Roses')
        expect(page).to have_content("Watering Requirements: 5 times/week")
      end
    end
  end
end