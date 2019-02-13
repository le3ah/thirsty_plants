require 'rails_helper' 

describe 'As a logged in user to the site' do
  describe 'on the garden show page' do
    it 'can update the garden info' do
      garden_old_name = 'My Garden'
      garden_old_zip = '11111'
      garden = create(:garden, name: garden_old_name, zip_code: garden_old_zip)
      
      visit garden_path(garden)
      
      click_on 'Update Garden Information'
      
      expect(current_path).to eq(edit_garden_path)
      expect(page).to have_field(:name, with: garden_old_name)
      expect(page).to have_field(:zip_code, with: garden_old_zip)
      
      garden_new_name = 'My FANCY Garden'
      garden_new_zip = '12345'
      fill_in :name, with: garden_new_name
      fill_in :zip_code, with: garden_new_zip
      click_button 'Update Garden'
      
      expect(current_path).to eq(garden_path(garden))
      expect(page).to have_content(garden_new_name)
      expect(page).to have_content(garden_new_zip)
      expect(page).to_not have_content(garden_old_name)
      expect(page).to_not have_content(garden_old_zip)
      expect(page).to have_content('Garden updated successfully!')
    end
  end
end

# 
# On my garden show page there is a link to edit the garden.
# When I click I see the old values in each field
# I input new values
# and click update
# And I am taken back to the garden show page
# There I see the new values
# 
# • include sad path