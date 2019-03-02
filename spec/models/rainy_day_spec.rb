require "rails_helper"

describe RainyDay do
  it 'exists' do
    rd = RainyDay.new(chance: 80, zip_code: '32984')
    expect(rd).to be_a(RainyDay)
  end
  describe 'class methods' do

    it '.gardens_to_check_weather_for' do
      user_1 = create(:user)
      create(:garden, owners: [user_1])
      user_2 = create(:user, telephone: '3034823981', receive_texts: true, rainy_day_notifications: true)
      garden_1 = create(:garden, owners: [user_2])
      garden_2 = create(:garden, owners: [user_2])
      expect(RainyDay.gardens_to_check_weather_for.count).to eq(2)
      expect(RainyDay.gardens_to_check_weather_for.to_set).to eq(Set[garden_1, garden_2])
    end

    describe ".generate_rainy_days" do
      def weather_service_stub(chance)
        {
          daily: {
            data: [
              {
                precipProbability: chance
              }
            ]
          }
        }
      end

      before(:each) do
        user_1 = create(:user)
        create(:garden, owners: [user_1])
        user_2 = create(:user, telephone: '3034823981', receive_texts: true, rainy_day_notifications: true)
        @garden_1 = create(:garden, owners: [user_2], zip_code: "80000")
        @garden_2 = create(:garden, owners: [user_2], zip_code: "80125", lat: '1', long: '-2')
        @garden_3 = create(:garden, owners: [user_2], zip_code: "80125", lat: '1', long: '-2')
      end
      it 'on a rainy day' do
        allow_any_instance_of(Weather).to receive(:chance_of_rain).with(0).and_return(70)
        results = RainyDay.generate_rainy_days
        expect(results.size).to eq(3)
        expect(results.first).to be_a(RainyDay)
        expect(results.first.chance_of_rain).to eq(70)
      end
      it 'on a not rainy enough day' do
        allow_any_instance_of(Weather).to receive(:chance_of_rain).with(0).and_return(49)
        results = RainyDay.generate_rainy_days
        expect(results.size).to eq(0)
      end
      it 'when a day is rainy some places but not others' do
        allow_any_instance_of(DarkSkyService).to receive(:get_weather).with(@garden_1.lat, @garden_1.long).and_return(weather_service_stub(0.8))
        allow_any_instance_of(DarkSkyService).to receive(:get_weather).with(@garden_2.lat, @garden_2.long).and_return(weather_service_stub(0.3))

        results = RainyDay.generate_rainy_days
        expect(results.size).to eq(1)
        expect(results.first.gardens).to eq([@garden_1])
      end
    end
    it 'zip_codes' do
      user_1 = create(:user)
      create(:garden, owners: [user_1])
      user_2 = create(:user, telephone: '3034823981', receive_texts: true, rainy_day_notifications: true)
      garden_1 = create(:garden, owners: [user_2], zip_code: "80000")
      garden_2 = create(:garden, owners: [user_2], zip_code: "80125")
      garden_3 = create(:garden, owners: [user_2], zip_code: "80125")
      expect(RainyDay.zip_codes).to eq([garden_1.zip_code, garden_2.zip_code])
    end
  end
  describe 'instance methods' do
    before(:each) do
      user_1 = create(:user)
      create(:garden, owners: [user_1])
      user_2 = create(:user, telephone: '3034823981', receive_texts: true, rainy_day_notifications: true)
      @garden_1 = create(:garden, owners: [user_2], zip_code: "80000")
      @garden_2 = create(:garden, owners: [user_2], zip_code: "80125")
      @garden_3 = create(:garden, owners: [user_2], zip_code: "80125")

      allow_any_instance_of(Weather).to receive(:chance_of_rain).with(0).and_return(70)
      @rainy_days = RainyDay.generate_rainy_days
    end
    it 'gardens' do
      rainy_day_with_one_garden = @rainy_days.find{ |day| @garden_1.zip_code == day.zip_code}
      rainy_day_with_two_gardens = @rainy_days.find{ |day| @garden_2.zip_code == day.zip_code}
      expect(rainy_day_with_two_gardens.gardens.to_set).to eq(Set[@garden_3, @garden_2])
      expect(rainy_day_with_one_garden.gardens).to eq([@garden_1])
    end
  end
end
