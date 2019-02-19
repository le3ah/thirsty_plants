require 'rails_helper'

RSpec.describe RainyDayTexterJob, type: :job do
  before(:each) do
    ActiveJob::Base.queue_adapter = :test
  end

  it "exists" do
    expect {
      RainyDayTexterJob.perform_later
    }.to have_enqueued_job(RainyDayTexterJob)
  end

  it 'reschedules itself for the next morning', :vcr, :allow_playback_repeats => true do
    expect {
      RainyDayTexterJob.perform_now
    }.to have_enqueued_job(RainyDayTexterJob).at(RainyDayTexterJob.early_next_morning)
  end

end
