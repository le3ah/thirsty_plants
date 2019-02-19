require 'rails_helper'

RSpec.describe RainyDayJob, type: :job do
  before(:each) do
    ActiveJob::Base.queue_adapter = :test
  end

  it "exists" do
    expect {
      RainyDayJob.perform_later
    }.to have_enqueued_job(RainyDayJob)
  end

  it 'reschedules itself for the next morning', :vcr do
    expect {
      RainyDayJob.perform_now
    }.to have_enqueued_job(RainyDayJob).at(RainyDayJob.early_next_morning)
  end

  it 'sends texts', :vcr do
    def weather_service_stub(chance)
      {
        daily: {
          data: [
            {
              precipProbability: chance
            }
          ]
        }
      }
    end

    user_1 = create(:user)
    user_2 = create(:user, telephone: ENV['ADMIN_PHONE_NUMBER'])
    @garden_1 = create(:garden, user: user_2, zip_code: "80000")
    @garden_2 = create(:garden, user: user_2, zip_code: "80125")
    @garden_3 = create(:garden, user: user_2, zip_code: "80125")
    create(:garden, user: user_1)

    garden_1_zip_code = double("garden_1_zip_code")
    allow(garden_1_zip_code).to receive(:latitude) { 100 }
    allow(garden_1_zip_code).to receive(:longitude) { 100 }
    garden_2_zip_code = double("garden_2_zip_code")
    allow(garden_2_zip_code).to receive(:latitude) { 200 }
    allow(garden_2_zip_code).to receive(:longitude) { 200 }
    allow(ZipcodeFinder).to receive(:new).with(@garden_1.zip_code).and_return(garden_1_zip_code)
    allow(ZipcodeFinder).to receive(:new).with(@garden_2.zip_code).and_return(garden_2_zip_code)

    allow_any_instance_of(DarkSkyService).to receive(:get_weather).with(100, 100).and_return(weather_service_stub(0.8))
    allow_any_instance_of(DarkSkyService).to receive(:get_weather).with(200, 200).and_return(weather_service_stub(0.3))


    allow(RainyDayTexter).to receive(:send_rainy_day_text).with(@garden_1, 80.0) {}
    RainyDayJob.new.send(:text_users)
    expect(RainyDayTexter).to have_received(:send_rainy_day_text).with(@garden_1, 80.0)
  end

end
