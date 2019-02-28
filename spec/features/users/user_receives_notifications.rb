require "rails_helper"

describe 'notifications' do
  describe 'user can manage notifactions' do
    it 'sees the user notification pane' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit dashboard_path
      click_on("Manage Notifications")
      expect(current_path).to eq(notifications_path)
      expect(page).to have_content("Manage Notifications")
      expect(page).to have_content("Recieve texts")
      expect(page).to have_content("Recieve emails")
      expect(page).to have_content("Rainy Day Notifications We'll let you know every morning at 8 when rain is likely in the forecast so you can consider giving your plants a moisture break.")
      expect(page).to have_content("Frost Notifications We'll let you know the night before when frost is likely in the forecast so you can take protective measures.")
      expect(page).to have_content("Missed Waterings We'll let you know if you forget to water your plants.")
    end
  end
  describe 'unwatered notication' do
    it 'sends when the user missing a watering for a plant' do
      clear_emails

      user = create(:user)
      garden = create(:garden, users: [user])
      plant = create(:plant, garden: garden)
      watering = create(:watering, plant: plant, water_time: 2.days.ago)

      UnwateredNotifierJob.perform_now

      open_email(user.email)
      expect(current_email).to have_content("Looks like you forgot to water: #{plant.name} in #{plant.garden.name} on #{watering.water_time.strftime('%A')}.")
      current_email.click_link("View Watering Schedule")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      expect(current_path).to eq(schedules_path)
    end
  end
end
