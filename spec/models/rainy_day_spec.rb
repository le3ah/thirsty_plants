require "rails_helper"

describe RainyDay do
  describe 'class methods' do
    it '.gardens_to_check_weather_for' do
      user_1 = create(:user)
      create(:garden, user: user_1)
      user_2 = create(:user, telephone: '23482398')
      garden_1 = create(:garden, user: user_2)
      garden_2 = create(:garden, user: user_2)
      expect(RainyDay.gardens_to_check_weather_for).to eq([garden_1, garden_2])
    end

    it ".generate_rainy_days" do
      rainy_weather = double(weather)
      allow(rainy_weather).to receive(chance_of_rain).and_return(70.0)
      rainy_weather = Weather
    end
    it 'returns all users whose gardens will be having a rainy day (50% or greater rain chance)' do

    end
  end
end
