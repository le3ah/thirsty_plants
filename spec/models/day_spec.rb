require "rails_helper"

describe Day do
  it 'exists' do
    day = Day.new(Time.now)
    expect(day).to be_a(Day)
  end
  it "::generate_days" do
    Day.generate_days(12, 4)
  end
  it ".css_id" do
    today = Day.new(Time.now)
    expect(today.css_id).to eq(Time.now.strftime('%b%d'))
  end
  it '.css_classes' do
    today = Day.new(Time.now)
    yesterday = Day.new(Time.now - 1.days)
    tomorrow = Day.new(Time.now + 1.days)
    expect(today.css_classes).to eq('row today')
    expect(yesterday.css_classes).to eq('row past-day')
    expect(tomorrow.css_classes).to eq('row')
  end
  it '.month_name' do
    day = Day.new(Time.now)
    expect(day.month_name).to eq(Time.now.strftime('%B'))
  end
  it '.day_of_week_name' do
    day = Day.new(Time.now)
    expect(day.day_of_week_name).to eq(Time.now.strftime('%A'))
  end
end
