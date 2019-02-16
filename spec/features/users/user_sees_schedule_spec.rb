require "rails_helper"
describe 'user sees schedule' do
  def sign_in(user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  it 'displays all waterings' do
    plant = create(:plant)
    plant_2 = create(:plant, garden: plant.garden)
    waterings = create_list(:watering, 2, plant: plant)
    create_list(:watering, 1, plant: plant_2)
    create_list(:watering, 1)

    sign_in(plant.garden.user)

    visit(dashboard_path)
    click_link "View Watering Schedule"
    # expect(page).to have_xpath(/today/)
    watering = waterings.first
    within("div[name='#{watering.water_time.strftime('%b%d')}']") do
      expect(page).to have_content(watering.water_time.strftime('%A'))
      expect(page).to have_content(watering.water_time.strftime('%b. %d'))
      expect(page).to have_content(plant.name, count: 2)
    end
    expect(page).to have_content(plant_2.name, count: 1)
    expect(page).to have_content(watering.plant.name, count: 2)
  end

  describe "changes are saved" do
    def set_watering(watering, value)
      watering_completed = find(:xpath, "//input[@id='watering-#{watering.id}-completed']", visible: false)
      watering_completed.set(value)
      find(:xpath, "//input[@id='update-watering-#{watering.id}']", visible: false).click
    end
    def check_watering(watering, value)
      watering_completed = find(:xpath, "//input[@id='watering-#{watering.id}-completed']", visible: false)
      expect(watering_completed.value).to eq(value)
    end
    before(:each) do
      @watering_1 = create(:watering)
      plant_1 = @watering_1.plant

      @user_1 = plant_1.garden.user

      plant_2 = create(:plant, garden: plant_1.garden)
      @watering_2 = create(:watering, plant: plant_2, completed: true)

      sign_in(@user_1)
      visit(schedules_path)
    end
    scenario 'when I water a plant' do
      set_watering(@watering_1, "true")
      sign_in(@user_1.reload)
      visit(schedules_path)
      check_watering(@watering_1, "true")
    end
    scenario 'when click again a watered plant to indicate it has not been watered' do
      check_watering(@watering_2, "true")
      set_watering(@watering_2, "false")
      sign_in(@user_1.reload)
      visit(schedules_path)
      check_watering(@watering_2, "false")
    end
  end
end
