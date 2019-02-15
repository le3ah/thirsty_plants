require 'rails_helper'

describe 'As a user to every page except the welcome page' do
  it 'Cannot see the navbar on welcome page' do
    visit root_path

    within '.navbar' do
      expect(page).to_not have_link('Dashboard')
      expect(page).to_not have_link('My Gardens')
      expect(page).to_not have_link('Schedule')
      expect(page).to_not have_link('Sign Out')
    end
  end

  it 'Navbar links work' do
    user = create(:user)
    garden = create(:garden, user: user)
    plant = create(:plant, garden: garden)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within '.navbar' do
      click_on ('Dashboard')
      expect(current_path).to eq(dashboard_path)
    end

    within '.navbar' do
      click_on('My Gardens')
      expect(current_path).to eq(gardens_path)
    end

    within '.navbar' do
      click_on('Schedule')
      expect(current_path).to eq(schedule_path)
    end

    within '.navbar' do
      click_on('Sign Out')
      expect(current_path).to eq(sign_out_path)
    end
  end

  it 'Can see the navbar on all pages (except welcome)' do
    user = create(:user)
    garden = create(:garden, user: user)
    plant = create(:plant, garden: garden)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within '.navbar' do
      expect(page).to have_link('Dashboard')
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('Schedule')
      expect(page).to have_link('Sign Out')
    end

    visit garden_plants_path(garden)

    within '.navbar' do
      expect(page).to have_link('Dashboard')
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('Schedule')
      expect(page).to have_link('Sign Out')
    end

    visit new_garden_plant_path(garden)

    within '.navbar' do
      expect(page).to have_link('Dashboard')
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('Schedule')
      expect(page).to have_link('Sign Out')
    end

    visit plant_path(plant)

    within '.navbar' do
      expect(page).to have_link('Dashboard')
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('Schedule')
      expect(page).to have_link('Sign Out')
    end

    visit gardens_path

    within '.navbar' do
      expect(page).to have_link('Dashboard')
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('Schedule')
      expect(page).to have_link('Sign Out')
    end

    visit new_garden_path

    within '.navbar' do
      expect(page).to have_link('Dashboard')
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('Schedule')
      expect(page).to have_link('Sign Out')
    end

    visit edit_garden_path(garden)

    within '.navbar' do
      expect(page).to have_link('Dashboard')
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('Schedule')
      expect(page).to have_link('Sign Out')
    end

    visit garden_path(garden)

    within '.navbar' do
      expect(page).to have_link('Dashboard')
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('Schedule')
      expect(page).to have_link('Sign Out')
    end
  end
end







# testing for logged in users not included in the test, will this be addressed by th
# card 35 not implemented yet
# Visitor cannot see site if not logged in
