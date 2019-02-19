require 'rails_helper'

RSpec.describe RainyDayJob, type: :job do
  before(:each) do
    ActiveJob::Base.queue_adapter = :test
  end

  it "exists", :vcr, :allow_playback_repeats => true do
    expect {
      RainyDayJob.perform_later
    }.to have_enqueued_job(RainyDayJob)
  end

  it 'reschedules itself for the next morning', :vcr, :allow_playback_repeats => true do
    expect {
      RainyDayJob.perform_now
    }.to have_enqueued_job(RainyDayJob).at(RainyDayJob.early_next_morning)
  end

end
