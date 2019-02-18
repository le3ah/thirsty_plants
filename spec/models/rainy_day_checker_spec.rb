require "rails_helper"

describe RainyDayChecker do
  describe 'class methods' do
    it 'users_with_phone_numbers' do
      user_1 = create(:user)
      user_2 = create(:user, telephone: '23482398')
      expect(RainyDayChecker.users_with_phone_numbers).to eq([user_2])
    end
    it '.gardens_to_check_weather_for' do
      user_1 = create(:user)
      create(:garden, user: user_1)
      user_2 = create(:user, telephone: '23482398')
      garden_1 = create(:garden, user: user_2)
      garden_2 = create(:garden, user: user_2)
      expect(RainyDayChecker.gardens_to_check_weather_for).to eq([garden_1, garden_2])
    end
    it 'returns all users whose gardens will be having a rainy day (50% or greater rain chance)' do
      # allow_any_instance_of(Weather).to receive(chance_of_rain).and_return()
      # c = RainyDayChecker.new
    end
  end
end
