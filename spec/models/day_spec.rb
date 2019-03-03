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
    today = Day.new(Date.today)
    yesterday = Day.new(Date.today - 1.days)
    tomorrow = Day.new(Date.today + 1.days)
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
    day = Day.new(Time.now.to_date)
    expect(day.day_of_week_name).to eq(Time.now.strftime('%A'))
  end

  it '.waterings' do
    plant = create(:plant, times_per_week: 7)
    watering = plant.reload.waterings.first
    day = Day.new(Time.now.to_date, watering.plant.garden.users.first)
    expect(day.waterings.first).to eq(watering)
  end

  it ".waterings?" do
    plant_1 = create(:plant, times_per_week: 7)
    watering = plant_1.reload.waterings.first
    day_1 = Day.new(Time.now.to_date, watering.plant.garden.users.first)
    expect(day_1.waterings?).to eq(true)

    plant_2 = create(:plant, times_per_week: 2)
    watering = plant_2.reload.waterings.first
    day_2 = Day.new(Time.now.to_date, watering.plant.garden.users.first)
    expect(day_2.waterings?).to eq(false)
  end
  it 'gardens' do
    not_the_users_garden = create(:garden, name: "not the users gardne")

    plant = create(:plant, times_per_week: 7)
    garden_1 = plant.garden
    owners = garden_1.owners
    garden_2 = create(:garden, owners: owners )
    plant_2 = create(:plant, garden: garden_2, times_per_week: 7)

    plant_3 = create(:plant, garden: garden_2, times_per_week: 7)
    plant_that_should_not_have_a_watering_today = create(:plant, garden: garden_2, times_per_week: 1)

    a_garden_the_user_caretakes =  create(:garden, caretakers: owners )
    plant_5 = create(:plant, garden: a_garden_the_user_caretakes, times_per_week: 7)

    day_1 = Day.new(Time.now.to_date, plant.garden.users.first)

    owned_gardens = day_1.gardens.owned
    expect(owned_gardens.to_a.count).to eq(2)
    expect(owned_gardens).to eq([garden_1, garden_2])
    expect(owned_gardens.first.plants).to eq([plant])
    expect(garden_2.plants.count).to eq(3)
    expect(owned_gardens.last.plants.to_set).to eq(Set[plant_2, plant_3])
    expect(owned_gardens.first.plants.first.waterings.to_a.count).to eq(1)
  end
end
