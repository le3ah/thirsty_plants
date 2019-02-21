require 'rails_helper'

describe 'As a caretaker' do
  describe 'on the garden index page' do
    it 'shows separate section for owner vs caretaker gardens' do
      owner = create(:user)
      caretaker = create(:user, first_name: 'Caretaker')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(caretaker)
      garden = create(:garden, owners: [owner])
      own_garden = create(:garden, owners: [caretaker])
      create(:user_garden, garden: garden, user: caretaker, relationship_type: 'caretaker')
      
      visit gardens_path
      
      expect(page).to have_content("#{caretaker.first_name}'s Greenery")
      expect(page).to have_content('Gardens Under My Care')
      
      within('.my-gardens') do
        expect(page).to have_content(own_garden.name)
        expect(page).to_not have_content(garden.name)
      end
      within('.caretaking-gardens') do
        expect(page).to have_content(garden.name)
        expect(page).to_not have_content(own_garden.name)
      end
    end
  end
end