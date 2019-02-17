require 'rails_helper'

RSpec.describe RainyDayTexterJob, type: :job do
  it "exists" do
    ActiveJob::Base.queue_adapter = :test
    expect {
      RainyDayTexterJob.perform_later
    }.to have_enqueued_job(RainyDayTexterJob)
  end
end
