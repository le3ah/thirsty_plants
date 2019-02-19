require "rails_helper"

describe Day do
  it 'exists' do
    day = Day.new(Time.now)
    expect(day).to be_a(Day)
  end
  it ".generate_days" do
    days = Day.generate_days(days_ago: 4, days_from_now: 7)
    expect(days.size).to eq(12)
    expect(days.first).to be_a(Day)
    expect(days.first.css_name).to eq(4.days.ago.localtime.strftime('%b%d'))
    expect(days.last.css_name).to eq(7.days.from_now.localtime.strftime('%b%d'))
  end
  it ".small_date" do
    today = Day.new(Time.now)
    expect(today.small_date).to eq(Time.now.strftime('%b. %d'))
  end
  it ".css_name" do
    today = Day.new(Time.now)
    expect(today.css_name).to eq(Time.now.strftime('%b%d'))
  end
  it ".css_id" do
    today = Day.new(Time.now)
    another_day = Day.new(Time.now - 1.days)
    expect(today.css_id).to eq('today')
    expect(another_day.css_id).to eq(nil)
  end
  it '.css_classes' do
    today = Day.new(Time.now)
    yesterday = Day.new(Time.now - 1.days)
    tomorrow = Day.new(Time.now + 1.days)
    expect(today.css_classes).to eq('row')
    expect(yesterday.css_classes).to eq('row past-day')
    expect(tomorrow.css_classes).to eq('row future-day')
  end

  it '.check_box_type' do
    today = Day.new(Time.now)
    another_day = Day.new(Time.now - 1.days)
    expect(today.check_box_type).to eq('enabled-checkbox')
    expect(another_day.check_box_type).to eq('disabled-checkbox')
  end

  it '.day_of_week_name' do
    day = Day.new(Time.now)
    expect(day.day_of_week_name).to eq(Time.now.strftime('%A'))
  end

  it '.waterings' do
    plant = create(:plant, times_per_week: 7)
    watering = plant.reload.waterings.first
    day = Day.new(Time.now, watering.plant.garden.user)
    expect(day.waterings.first).to eq(watering)
  end
end
