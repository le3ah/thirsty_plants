require 'rails_helper'

describe 'As a user to every page except the welcome page' do
  it 'Cannot see the navbar on welcome page' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    within '.navbar navbar-expand-lg' do
      expect(page).to_not have_link('Dashboard')
      expect(page).to_not have_link('My Gardens')
      expect(page).to_not have_link('Schedule')
      expect(page).to_not have_link('Sign Out')
    end
  end

  it 'Navbar links work' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)


  end

  it 'Can see the navbar on all pages (except welcome)' do
    user = create(:user)
    garden = create(:garden, user: user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within '.navbar navbar-expand-lg' do
      expect(page).to have_link('Dashboard')
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('Schedule')
      expect(page).to have_link('Sign Out')
    end

    visit garden_plants_path()

    within '.navbar navbar-expand-lg' do
      expect(page).to have_link('Dashboard')
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('Schedule')
      expect(page).to have_link('Sign Out')
    end

    visit new_garden_plant_path

    within '.navbar navbar-expand-lg' do
      expect(page).to have_link('Dashboard')
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('Schedule')
      expect(page).to have_link('Sign Out')
    end

    visit plant_path()

    within '.navbar navbar-expand-lg' do
      expect(page).to have_link('Dashboard')
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('Schedule')
      expect(page).to have_link('Sign Out')
    end

    visit gardens_path

    within '.navbar navbar-expand-lg' do
      expect(page).to have_link('Dashboard')
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('Schedule')
      expect(page).to have_link('Sign Out')
    end

    visit new_garden_path

    within '.navbar navbar-expand-lg' do
      expect(page).to have_link('Dashboard')
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('Schedule')
      expect(page).to have_link('Sign Out')
    end

    visit edit_garden_path

    within '.navbar navbar-expand-lg' do
      expect(page).to have_link('Dashboard')
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('Schedule')
      expect(page).to have_link('Sign Out')
    end

    visit garden_path

    within '.navbar navbar-expand-lg' do
      expect(page).to have_link('Dashboard')
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('Schedule')
      expect(page).to have_link('Sign Out')
    end
end







# testing for logged in users not included in the test, will this be addressed by th
# card 35 not implemented yet
# Visitor cannot see site if not logged in
