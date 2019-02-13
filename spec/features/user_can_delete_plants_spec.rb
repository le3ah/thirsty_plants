require 'rails_helper'

describe 'As a user logged in to the site' do
  describe 'on a garden show page' do
    it 'can delete a plant' do
      garden = create(:garden)
      plant_1 = create(:plant, garden: garden)
      plant_2 = create(:plant, garden: garden)
      
      visit garden_path(garden)
      
      expect(page).to have_content(plant_1.name)
      expect(page).to have_content(plant_2.name)
      
      within("#plant-#{plant_1.id}") do
        click_on 'Remove Plant'
      end
      
      expect(current_path).to eq(garden_path(garden))
      expect(page).to have_content('Goodbye dear plant')
      expect(page).to_not have_content(plant_1.name)
      expect(page).to have_content(plant_2.name)
    end
  end
end

# From my garden's show page, I have the ability to delete my plant. 
# When I select the delete button, I am returned to my garden's show page, and I no longer see that plant. 
# I see a flash message saying "goodbye dear plant"