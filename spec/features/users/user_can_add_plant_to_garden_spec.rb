require 'rails_helper'

describe 'As a logged in user to the site' do
  describe 'on a garden show page' do
    it 'can add a new plant to their garden' do
      user = create(:user)
      garden = create(:garden, owners: [user])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit garden_path(garden)
      
      within(".garden-links") do
        within('#new-plant-button')do
          click_on 'Add a Plant to Your Garden!'
        end
      end

      expect(current_path).to eq(new_garden_plant_path(garden))
      fill_in :plant_name, with: 'Roses'
      fill_in :plant_times_per_week, with: 5
      click_button 'Create Plant'

      expect(current_path).to eq(garden_path(garden))
      expect(page).to have_content("Party in my plants, you've created a new plant!")
      within '.plants-container' do
        expect(page).to have_content('Roses')
        expect(page).to have_content("Watering Requirements: 5.0 times/week")
      end
    end

    it 'cannot add a plant with incomplete information' do
      user = create(:user)
      garden = create(:garden, owners: [user])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit new_garden_plant_path(garden)
      click_button 'Create Plant'

      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Times per week can't be blank")
    end
  end
end
