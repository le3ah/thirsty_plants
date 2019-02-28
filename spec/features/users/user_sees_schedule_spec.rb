require "rails_helper"
describe 'user sees schedule' do
  def sign_in(user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  it 'displays all waterings', :vcr do
    plant = create(:plant)
    garden_1 = plant.garden

    plant_2 = create(:plant, garden: plant.garden)

    garden_2 = create(:garden, owners: plant.garden.owners )
    Watering.destroy_all
    create(:garden)
    plant_3 = create(:plant, garden: garden_2, times_per_week: 7)

    waterings = create_list(:watering, 2, plant: plant)
    create_list(:watering, 1, plant: plant_2)
    create_list(:watering, 1)

    sign_in(plant.garden.owners.first)

    visit(dashboard_path)
    click_link "View Watering Schedule"
    watering = waterings.first

    expect(page).to have_content(plant_2.name, count: 1)
    expect(page).to have_content(watering.plant.name, count: 2)

    within("div[name='#{watering.water_time.strftime('%b%d')}']") do
      expect(page).to have_content(watering.water_time.strftime('%A'))
      expect(page).to have_content(watering.water_time.strftime('%b. %d'))
      within("#garden-#{garden_2.id}-#{watering.water_time.strftime('%b%d')}") do
        expect(page).to have_link(plant_3.name)
      end
      within("#garden-#{garden_1.id}-#{watering.water_time.strftime('%b%d')}") do
        expect(page).to have_link(plant.name, count: 2)
      end
      
      within "#watering-#{plant.waterings.first.id}-name" do
        click_link(plant.name)
      end
      expect(current_path).to eq(plant_path(plant))
    end
  end

  describe "changes are saved" do
    def set_watering(watering, value)
      watering_completed = find(:xpath, "//input[@id='watering-#{watering.id}-completed']", visible: false)
      watering_completed.set(value)
      find(:xpath, "//input[@id='update-watering-#{watering.id}']", visible: false).click
    end
    def set_watering_time(watering, value)
      watering_time = find(:xpath, "//input[@id='watering-#{watering.id}-water-time']", visible: false)
      watering_time.set(value)
      find(:xpath, "//input[@id='update-watering-#{watering.id}']", visible: false).click
    end
    def check_watering(watering, value)
      watering_completed = find(:xpath, "//input[@id='watering-#{watering.id}-completed']", visible: false)
      expect(watering_completed.value).to eq(value)
    end
    def check_name_strikethrough(watering, boolean)
      plant_name = page.find("#watering-#{watering.id}-name")
      css_classes = plant_name[:class] || []
      expect(css_classes.include?("watered-plant-name")).to eq(boolean)
    end
    before(:each) do
      @watering_1 = create(:watering)
      plant_1 = @watering_1.plant

      @user_1 = plant_1.garden.owners.first

      plant_2 = create(:plant, garden: plant_1.garden)
      @watering_2 = create(:watering, plant: plant_2, completed: true)

      sign_in(@user_1)
      visit(schedules_path)
    end
    scenario 'when I water a plant' do
      check_name_strikethrough(@watering_1, false)
      set_watering(@watering_1, "true")
      sign_in(@user_1.reload)
      visit(schedules_path)
      check_name_strikethrough(@watering_1, true)
      check_watering(@watering_1, "true")
    end
    scenario 'when click again a watered plant to indicate it has not been watered' do
      check_name_strikethrough(@watering_2, true)
      check_watering(@watering_2, "true")
      set_watering(@watering_2, "false")
      sign_in(@user_1.reload)
      visit(schedules_path)
      check_watering(@watering_2, "false")
      check_name_strikethrough(@watering_2, false)
    end
    scenario 'when I move a watering it saves and updates the watering date' do
      start_water_time = @watering_1.water_time
      new_time = (start_water_time + 2.days).strftime('%b%d')

      set_watering_time(@watering_1, new_time)
      visit schedules_path

      expect(@watering_1.reload.water_time.strftime('%b%d')).to eq(new_time)
      within("[name=#{new_time}]") do
        expect(page).to have_content(@watering_1.plant.name)
      end
    end
    scenario 'when there are no waterings on a particular day, I see a message' do
      yesterday = Time.now.to_date - 1.days
      within("[name=#{yesterday.strftime('%b%d')}]") do
        expect(page).to have_content("No waterings scheduled today.")
      end
    end
  end
end
