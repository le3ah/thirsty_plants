require 'rails_helper'

describe 'As a logged in user to the site' do
  describe 'on the garden show page' do
    it 'can update the garden info' do

      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      garden_old_name = 'old name'
      garden_old_zip = '11111'
      garden = create(:garden, name: garden_old_name, zip_code: garden_old_zip)

      visit garden_path(garden)
      within (".garden-links") do
          within('#update-button')do
          click_on 'Update Garden Information'
        end
      end
      expect(current_path).to eq(edit_garden_path(garden))
      expect(page).to have_field(:garden_name, with: garden_old_name)
      expect(page).to have_field(:garden_zip_code, with: garden_old_zip)


      garden_new_name = 'My FANCY Garden'
      garden_new_zip = '12345'
      fill_in :garden_name, with: garden_new_name
      fill_in :garden_zip_code, with: garden_new_zip
      click_button 'Update Garden'

      expect(current_path).to eq(garden_path(garden))
      expect(page).to have_content(garden_new_name)
      expect(page).to have_content(garden_new_zip)
      expect(page).to_not have_content(garden_old_name)
      expect(page).to_not have_content(garden_old_zip)
      expect(page).to have_content('Garden updated successfully!')
    end

    it 'cannot update the garden with blank info' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      garden_old_name = 'My Garden'
      garden_old_zip = '11111'
      garden = create(:garden, name: garden_old_name, zip_code: garden_old_zip)

      visit edit_garden_path(garden)
      fill_in :garden_name, with: ''
      fill_in :garden_zip_code, with: ''
      click_button 'Update Garden'

      expect(page).to have_content('Update Garden Information')
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Zip code can't be blank")
    end
  end
end
