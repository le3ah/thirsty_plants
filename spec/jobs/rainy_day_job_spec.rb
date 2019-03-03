require 'rails_helper'

RSpec.describe RainyDayJob, type: :job do
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
  def stub_twillio
    messages = double('messages')
    allow(messages).to receive(:create).with(anything())
    account = double('account')
    allow(account).to receive(:messages) { messages }
    api = double('api')
    allow(api).to receive(:account) { account }
    @fake_twillio = spy('MyTwillioClient')
    allow(@fake_twillio).to receive(:api) { api }
    stub_const('MyTwillioClient', @fake_twillio)
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
  it 'sends a request to Twillio' do
    stub_twillio
    user = create(:user, telephone: ENV['ADMIN_PHONE_NUMBER'], receives_texts: true, rainy_day_notifications: true)
    create(:user_garden, user: user)
    allow_any_instance_of(DarkSkyService).to receive(:get_weather).with(anything(), anything()).and_return(weather_service_stub(0.8))
    RainyDayJob.new.perform
    expect(MyTwillioClient).to have_received(:api)
  end

  describe 'writes texts and emails to the right users' do
    fake_zip = Struct.new(:code, :lat, :long)
    let(:rainy_zip) { fake_zip.new("rainy_zip", '-1', '10') }
    let(:unrainy_zip) { fake_zip.new("unrainy_zip", '-100', '440') }
    before(:each) do
      allow_any_instance_of(DarkSkyService).to receive(:get_weather).with(rainy_zip.lat, rainy_zip.long).and_return(weather_service_stub(0.8))
      allow_any_instance_of(DarkSkyService).to receive(:get_weather).with(unrainy_zip.lat, unrainy_zip.long).and_return(weather_service_stub(0.3))
      @rainy_garden = attributes_for(:garden, zip_code: rainy_zip.code, lat: rainy_zip.lat, long: rainy_zip.long)
      @unrainy_garden = attributes_for(:garden, zip_code: unrainy_zip.code, lat: unrainy_zip.lat, long: unrainy_zip.long)
      @mock_texter = spy('RainyDayTexter')
      stub_const('RainyDayTexter', @mock_texter)
      @mock_mailer = spy('RainyDayMailer')
      stub_const('RainyDayMailer', @mock_mailer)
    end
    it 'sends users texts' do
      unshared_garden = Garden.create!(@rainy_garden)
      shared_garden = Garden.create!(@rainy_garden)
      user_1 = create(:user, gardens: [shared_garden], telephone: ENV['ADMIN_PHONE_NUMBER'], receives_texts: true, receives_emails: false, rainy_day_notifications: true)
      caretaker = create(:user, telephone: ENV['ADMIN_PHONE_NUMBER'], receives_texts: true, receives_emails: false, rainy_day_notifications: true)
      user_1.gardens.first.caretakers = [caretaker]
      other_user = create(:user, gardens: [unshared_garden], telephone: ENV['ADMIN_PHONE_NUMBER'], receives_texts: true, receives_emails: false, rainy_day_notifications: true)
      RainyDayJob.perform_now

      expect(@mock_texter).to have_received(:send_rainy_day_text).with(user_1, shared_garden, 80.0)
      expect(@mock_texter).to have_received(:send_rainy_day_text).with(caretaker, shared_garden, 80.0)
      expect(@mock_texter).to have_received(:send_rainy_day_text).with(other_user, unshared_garden, 80.0)
    end
    it 'refrains from sending users texts, while sending email' do
      unshared_garden = Garden.create!(@rainy_garden)
      shared_garden = Garden.create!(@rainy_garden)
      user_1 = create(:user, gardens: [shared_garden], telephone: ENV['ADMIN_PHONE_NUMBER'], receives_texts: false, receives_emails: true, rainy_day_notifications: true)
      caretaker = create(:user, telephone: ENV['ADMIN_PHONE_NUMBER'], receives_texts: false, receives_emails: false, rainy_day_notifications: false)
      user_1.gardens.first.caretakers = [caretaker]
      other_user = create(:user, gardens: [unshared_garden], telephone: ENV['ADMIN_PHONE_NUMBER'], receives_texts: true, receives_emails: false, rainy_day_notifications: false)
      RainyDayJob.perform_now

      expect(@mock_texter).to_not have_received(:send_rainy_day_text).with(user_1, shared_garden, 80.0)
      expect(@mock_texter).to_not have_received(:send_rainy_day_text).with(caretaker, shared_garden, 80.0)
      expect(@mock_texter).to_not have_received(:send_rainy_day_text).with(other_user, unshared_garden, 80.0)
      expect(@mock_mailer).to have_received(:inform).with(user_1, shared_garden, 80.0)
    end
    it 'refrains from sending users texts even when other users for that garden recieve texts' do
      shared_garden = Garden.create!(@rainy_garden)
      user_1 = create(:user, gardens: [shared_garden], telephone: ENV['ADMIN_PHONE_NUMBER'], receives_texts: false, receives_emails: true, rainy_day_notifications: true)
      caretaker = create(:user, telephone: ENV['ADMIN_PHONE_NUMBER'], receives_texts: true, receives_emails: false, rainy_day_notifications: true)
      user_1.gardens.first.caretakers = [caretaker]
      RainyDayJob.perform_now
      expect(@mock_texter).to have_received(:send_rainy_day_text).with(caretaker, shared_garden, 80.0)
      expect(@mock_texter).to_not have_received(:send_rainy_day_text).with(user_1, shared_garden, 80.0)
    end
  end
end
