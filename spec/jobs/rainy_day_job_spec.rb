require 'rails_helper'

RSpec.describe RainyDayJob, type: :job do
  def stub_twillio
    messages = double('messages')
    allow(messages).to receive(:create).with(anything())
    account = double('account')
    allow(account).to receive(:messages) { messages }
    api = double('api')
    allow(api).to receive(:account) { account }
    allow(MyTwillioClient).to receive(:api).and_return(api)
  end
  before(:each) do
    ActiveJob::Base.queue_adapter = :test
  end

  it "exists" do
    stub_twillio
    expect {
      RainyDayJob.perform_later
    }.to have_enqueued_job(RainyDayJob)
  end

  it 'sends texts' do
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
    @garden_1 = create(:garden, owners: [user_2], zip_code: "80000")
    @garden_2 = create(:garden, owners: [user_2], zip_code: "80125", lat: '1', long: '-1')
    @garden_3 = create(:garden, owners: [user_2], zip_code: "80125", lat: '1', long: '-1')
    create(:garden, owners: [user_1])

    allow_any_instance_of(DarkSkyService).to receive(:get_weather).with(@garden_1.lat, @garden_1.long).and_return(weather_service_stub(0.8))
    allow_any_instance_of(DarkSkyService).to receive(:get_weather).with(@garden_2.lat, @garden_2.long).and_return(weather_service_stub(0.3))
    allow_any_instance_of(DarkSkyService).to receive(:get_weather).with(@garden_3.lat, @garden_3.long).and_return(weather_service_stub(0.3))

    allow(RainyDayTexter).to receive(:send_rainy_day_text).with(@garden_1.users.first, @garden_1, 80.0) {}
    RainyDayJob.new.send(:text_users)
    expect(RainyDayTexter).to have_received(:send_rainy_day_text).with(@garden_1.users.first, @garden_1, 80.0)
  end

end
