require 'rails_helper'

describe 'As a user logged in to the site' do
  describe 'on a garden show page' do
    it 'can delete a plant' do

      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

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
