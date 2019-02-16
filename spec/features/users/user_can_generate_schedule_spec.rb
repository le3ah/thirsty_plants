require 'rails_helper'

describe 'As a logged in user when visiting my dashboard' do
  it 'sees a link to generate a schedule', :vcr do
    plant = create(:plant, times_per_week: 4)
    user = plant.garden.user

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path
    click_button("Generate Watering Schedule")

    expect(current_path).to eq(schedules_path)

    within("div[name='#{Date.today.strftime('%b%d')}']") do
      expect(page).to_not have_content(plant.name)
    end
    within("div[name='#{1.days.from_now.strftime('%b%d')}']") do
      expect(page).to have_content(plant.name)
    end

    within("div[name='#{2.days.from_now.strftime('%b%d')}']") do
      expect(page).to_not have_content(plant.name)
    end
    within("div[name='#{3.days.from_now.strftime('%b%d')}']") do
      expect(page).to have_content(plant.name)
    end
    within("div[name='#{4.days.from_now.strftime('%b%d')}']") do
      expect(page).to_not have_content(plant.name)
    end
    within("div[name='#{5.days.from_now.strftime('%b%d')}']") do
      expect(page).to have_content(plant.name)
    end
    within("div[name='#{6.days.from_now.strftime('%b%d')}']") do
      expect(page).to_not have_content(plant.name)
    end
    within("div[name='#{7.days.from_now.strftime('%b%d')}']") do
      expect(page).to have_content(plant.name)
    end


    within("div[name='#{1.days.ago.strftime('%b%d')}']") do
      expect(page).to_not have_content(plant.name)
    end
    within("div[name='#{2.days.ago.strftime('%b%d')}']") do
      expect(page).to_not have_content(plant.name)
    end
    within("div[name='#{3.days.ago.strftime('%b%d')}']") do
      expect(page).to_not have_content(plant.name)
    end
  end
end
