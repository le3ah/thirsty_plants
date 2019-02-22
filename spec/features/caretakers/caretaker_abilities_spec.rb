require 'rails_helper'

describe 'As a caretaker of a garden' do
  it 'cannot delete that garden' do
    owner = create(:user)
    caretaker = create(:user, first_name: 'Caretaker')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(caretaker)
    garden = create(:garden, owners: [owner])
    create(:user_garden, garden: garden, user: caretaker, relationship_type: 'caretaker')
    own_garden = create(:garden, owners: [caretaker])
    
    visit garden_path(garden)
    
    expect(page).to_not have_button('Delete Garden')
  end
  it 'cannot update that garden' do
    owner = create(:user)
    caretaker = create(:user, first_name: 'Caretaker')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(caretaker)
    garden = create(:garden, owners: [owner])
    create(:user_garden, garden: garden, user: caretaker, relationship_type: 'caretaker')
    own_garden = create(:garden, owners: [caretaker])
    
    visit garden_path(garden)
    
    expect(page).to_not have_link('Update Garden Information')
    
    visit edit_garden_path(garden)
    expect(status_code).to eq(404)
  end
  it 'cannot add plants to that garden' do
    owner = create(:user)
    caretaker = create(:user, first_name: 'Caretaker')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(caretaker)
    garden = create(:garden, owners: [owner])
    create(:user_garden, garden: garden, user: caretaker, relationship_type: 'caretaker')
    own_garden = create(:garden, owners: [caretaker])
    
    visit garden_path(garden)
    
    expect(page).to_not have_link('Add a Plant to Your Garden!')
  end
  it 'cannot edit plants for that garden' do
    owner = create(:user)
    caretaker = create(:user, first_name: 'Caretaker')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(caretaker)
    garden = create(:garden, owners: [owner])
    plant = create(:plant, garden: garden)
    create(:user_garden, garden: garden, user: caretaker, relationship_type: 'caretaker')
    own_garden = create(:garden, owners: [caretaker])
    
    visit edit_plant_path(plant)
    expect(status_code).to eq(404)
  end
  it 'cannot delete a plant from that garden' do
    owner = create(:user)
    caretaker = create(:user, first_name: 'Caretaker')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(caretaker)
    garden = create(:garden, owners: [owner])
    plant = create(:plant, garden: garden)
    create(:user_garden, garden: garden, user: caretaker, relationship_type: 'caretaker')
    own_garden = create(:garden, owners: [caretaker])
    
    visit garden_path(garden)
    
    expect(page).to_not have_button('Remove Plant')
  end
  it 'cannot invite other caretakers to the garden' do
    owner = create(:user)
    caretaker = create(:user, first_name: 'Caretaker')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(caretaker)
    garden = create(:garden, owners: [owner])
    plant = create(:plant, garden: garden)
    create(:user_garden, garden: garden, user: caretaker, relationship_type: 'caretaker')
    own_garden = create(:garden, owners: [caretaker])
    
    visit gardens_path
    
    within('.caretaking-gardens') do
      expect(page).to_not have_link('Add Caretaker for this Garden')
    end
  end
  it 'can still do owner things with own garden' do
    owner = create(:user)
    caretaker = create(:user, first_name: 'Caretaker')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(caretaker)
    garden = create(:garden, owners: [owner])
    plant = create(:plant, garden: garden)
    create(:user_garden, garden: garden, user: caretaker, relationship_type: 'caretaker')
    own_garden = create(:garden, owners: [caretaker])
    own_plant = create(:plant, garden: own_garden)
    
    visit garden_path(own_garden)
    expect(page).to have_button('Delete Garden') 
    expect(page).to have_link('Update Garden Information')
    expect(page).to have_link('Add a Plant to Your Garden!')
    expect(page).to have_button('Remove Plant')
    
    visit edit_plant_path(own_plant)
    expect(status_code).to eq(200)
    
    visit gardens_path
    within('.my-gardens') do
      expect(page).to have_link('Add Caretaker for this Garden')
    end
  end
end