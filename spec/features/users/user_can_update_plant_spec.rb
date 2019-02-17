require 'rails_helper'

describe 'As a logged in user to the site' do
  describe 'on the garden show page' do
    it 'can update the plant info' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      plant_name = "Sunflower"
      plant_water = 3.to_f
      garden = create(:garden, name: "My garden", zip_code: 80206)
      plant_1 = create(:plant, name: plant_name, times_per_week: plant_water, garden: garden)
      plant_2 = create(:plant, name: "Pansy", times_per_week: 2, garden: garden)

      visit garden_path(garden)

      within ("#plant-#{plant_1.id}") do
        within('#edit-button') do
          click_on 'Edit My Plant'
        end
      end

      expect(current_path).to eq(edit_plant_path(plant_1))
      expect(page).to have_field(:plant_name, with: plant_name)
      expect(page).to have_field(:plant_times_per_week, with: plant_water)

      new_plant_name = 'Cactus'
      new_plant_watering = 1
      fill_in :plant_name, with: new_plant_name
      fill_in :plant_times_per_week, with: new_plant_watering
      click_button 'Update Plant'

      expect(current_path).to eq(garden_path(garden))
      within ("#plant-#{plant_1.id}") do
        expect(page).to have_content(new_plant_name)
        expect(page).to have_content(new_plant_watering)
        expect(page).to_not have_content(plant_name)
        expect(page).to_not have_content(plant_water)
      end
      expect(page).to have_content('Plant updated successfully!')
    end
  end
end
