require 'rails_helper'

describe 'As a logged in user when I add a plant' do
  it 'generates waterings for that plant on the schedule', :vcr do
    plant = create(:plant, times_per_week: 4)
    user = plant.garden.user

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    click_link("View Watering Schedule")

    expect(current_path).to eq(schedules_path)

    within("div[name='#{Date.today.strftime('%b%d')}']") do
      expect(page).to_not have_content(plant.name)
    end
    within("div[name='#{1.days.from_now.localtime.strftime('%b%d')}']") do
      expect(page).to have_content(plant.name)
    end

    within("div[name='#{2.days.from_now.localtime.strftime('%b%d')}']") do
      expect(page).to_not have_content(plant.name)
    end
    within("div[name='#{3.days.from_now.localtime.strftime('%b%d')}']") do
      expect(page).to have_content(plant.name)
    end
    within("div[name='#{4.days.from_now.localtime.strftime('%b%d')}']") do
      expect(page).to_not have_content(plant.name)
    end
    within("div[name='#{5.days.from_now.localtime.strftime('%b%d')}']") do
      expect(page).to have_content(plant.name)
    end
    within("div[name='#{6.days.from_now.localtime.strftime('%b%d')}']") do
      expect(page).to_not have_content(plant.name)
    end
    within("div[name='#{7.days.from_now.localtime.strftime('%b%d')}']") do
      expect(page).to have_content(plant.name)
    end


    within("div[name='#{1.days.ago.localtime.strftime('%b%d')}']") do
      expect(page).to_not have_content(plant.name)
    end
    within("div[name='#{2.days.ago.localtime.strftime('%b%d')}']") do
      expect(page).to_not have_content(plant.name)
    end
    within("div[name='#{3.days.ago.localtime.strftime('%b%d')}']") do
      expect(page).to_not have_content(plant.name)
    end
  end
  
  it 'updates the schedule when you update the times per week for a plant' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    garden = create(:garden, user: user)
    plant = create(:plant, garden: garden, times_per_week: 3)
    
    visit edit_plant_path(plant)
    
    fill_in :plant_times_per_week, with: 7
    click_button 'Update Plant'
    
    expect(plant.reload.times_per_week).to eq(7)
    expect(plant.waterings.count).to eq(8)
    
    visit schedules_path
    
    within("div[name='#{Date.today.strftime('%b%d')}']") do
      expect(page).to have_content(plant.name, count: 1)
    end
    within("div[name='#{1.days.from_now.localtime.strftime('%b%d')}']") do
      expect(page).to have_content(plant.name, count: 1)
    end
    within("div[name='#{2.days.from_now.localtime.strftime('%b%d')}']") do
      expect(page).to have_content(plant.name, count: 1)
    end
    within("div[name='#{3.days.from_now.localtime.strftime('%b%d')}']") do
      expect(page).to have_content(plant.name, count: 1)
    end
    within("div[name='#{4.days.from_now.localtime.strftime('%b%d')}']") do
      expect(page).to have_content(plant.name, count: 1)
    end
    within("div[name='#{5.days.from_now.localtime.strftime('%b%d')}']") do
      expect(page).to have_content(plant.name, count: 1)
    end
    within("div[name='#{6.days.from_now.localtime.strftime('%b%d')}']") do
      expect(page).to have_content(plant.name, count: 1)
    end
    within("div[name='#{7.days.from_now.localtime.strftime('%b%d')}']") do
      expect(page).to have_content(plant.name, count: 1)
    end
  end
end
