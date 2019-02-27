require "rails_helper"

describe 'unwatered notication' do
  it 'sends when the user missing a watering for a plant' do
    clear_emails

    user = create(:user)
    garden = create(:garden, users: [user])
    plant = create(:plant, garden: garden)
    watering = create(:watering, plant: plant, water_time: 2.days.ago)

    UnwateredNotifierJob.perform_now

    open_email(user.email)
    expect(current_email).to have_content("Looks like you missed some waterings: #{plant.name} on #{watering.water_time.strftime('%A')}.")
    current_email.click_link("View Watering Schedule")
    allow_any_instance_of(ApplicationCotroller).to receive(:current_user).and_return(user)
    expect(current_path).to eq(schedules_path)
  end
end
