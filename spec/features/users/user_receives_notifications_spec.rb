require "rails_helper"

describe 'notifications' do
  describe 'user can manage notifactions' do
    before(:each) do
      @user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end
    it 'sees the user notification pane' do
      visit dashboard_path
      click_on("Settings")
      expect(current_path).to eq(settings_path)
      expect(page).to have_content("Notifications")
      within "#notifications" do
        expect(page).to have_content("Receive email")
        expect(page).to have_content("Receive texts")
        expect(page).to have_content("Rainy day notifications")
        expect(page).to have_content("We'll let you know every morning at 8 when rain is likely in the forecast so you can consider giving your plants a moisture break.")
        expect(page).to have_content("Frost notifications")
        expect(page).to have_content("We'll let you know the night before when frost is likely in the forecast so you can take protective measures.")
        expect(page).to have_content("Missed watering notifications")
        expect(page).to have_content("We'll let you know if you forget to water your plants.")
      end
    end
    it 'can update their notifications' do
      visit settings_path
      expect(@user.rainy_day_notifications).to eq(false)
      expect(@user.frost_notifications).to eq(false)
      expect(@user.receive_texts).to eq(false)
      find(:css, "#user_rainy_day_notifications").set(true)
      find(:css, "#user_frost_notifications").set(true)
      click_on("Save")
      expect(current_path).to eq(settings_path)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user.reload)
      visit schedules_path
      expect(@user.rainy_day_notifications).to eq(true)
      expect(@user.frost_notifications).to eq(true)
    end
    it 'only lets you receive texts if you give your phone number' do
      visit settings_path
      find(:css, "#user_receive_texts").set(true)
      click_on("Save")
      save_and_open_page
      expect(page).to have_content("Phone number can't be blank if you'd like to receive texts")
      expect(@user.reload.receive_texts).to eq(false)
    end
  end

  describe 'unwatered notication' do
    it 'sends when the user missing a watering for a plant' do
      clear_emails

      user = create(:user)
      garden = create(:garden, users: [user])
      plant = create(:plant, garden: garden)
      watering = create(:watering, plant: plant, water_time: 3.days.ago)

      UnwateredNotifierJob.perform_now
      open_email(user.email)
      expect(current_email).to have_content("Looks like you forgot to water: #{plant.name} in #{plant.garden.name} on #{watering.water_time.strftime('%A')}.")
      current_email.click_link("View Watering Schedule")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      expect(current_path).to eq(schedules_path)
    end
    it 'sends only to the right users' do
      user_1 = create(:user)
      user_2 = create(:user)
      user_3 = create(:user, receive_emails: false)
      user_4 = create(:user, missed_watering_notifications: false)

      users = [user_1, user_2, user_3, user_4]
      users.each do |user|
        garden = create(:garden, users: [user])
        plant = create(:plant, garden: garden)
        create(:watering, plant: plant, water_time: 3.days.ago)
      end
      user_5 = create(:user)

      mock_mailer = spy('UnwateredNotifierMailer')
      stub_const('UnwateredNotifierMailer', mock_mailer)
      UnwateredNotifierJob.perform_now

      expect(mock_mailer).to have_received(:inform).with(user_1)
      expect(mock_mailer).to have_received(:inform).with(user_2)
      expect(mock_mailer).to_not have_received(:inform).with(user_3)
      expect(mock_mailer).to_not have_received(:inform).with(user_4)
      expect(mock_mailer).to_not have_received(:inform).with(user_5)
    end
  end
end
