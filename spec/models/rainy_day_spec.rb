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
      user_2 = create(:user, telephone: '23482398')
      garden_1 = create(:garden, owners: [user_2])
      garden_2 = create(:garden, owners: [user_2])
      expect(RainyDay.gardens_to_check_weather_for).to eq([garden_1, garden_2])
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
        user_2 = create(:user, telephone: '23482398')
        @garden_1 = create(:garden, owners: [user_2], zip_code: "80000")
        @garden_2 = create(:garden, owners: [user_2], zip_code: "80125")
        @garden_3 = create(:garden, owners: [user_2], zip_code: "80125")
      end
      it 'on a rainy day' do
        allow_any_instance_of(Weather).to receive(:chance_of_rain).with(0).and_return(70)
        results = RainyDay.generate_rainy_days
        expect(results.size).to eq(3)
        expect(results.first).to be_a(RainyDay)
        expect(results.first.chance_of_rain).to eq(70)
        expect(results.first.zip_code).to eq(@garden_1.zip_code)
      end
      it 'on a not rainy enough day' do
        allow_any_instance_of(Weather).to receive(:chance_of_rain).with(0).and_return(49)
        results = RainyDay.generate_rainy_days
        expect(results.size).to eq(0)
      end
      it 'when a day is rainy some places but not others' do
        # garden_1_zip_code = double("garden_1_zip_code")
        # allow(garden_1_zip_code).to receive(:latitude) { 100 }
        # allow(garden_1_zip_code).to receive(:longitude) { 100 }
        # garden_2_zip_code = double("garden_2_zip_code")
        # allow(garden_2_zip_code).to receive(:latitude) { 200 }
        # allow(garden_2_zip_code).to receive(:longitude) { 200 }
        # allow(ZipcodeFinder).to receive(:new).with(@garden_1.zip_code).and_return(garden_1_zip_code)
        # allow(ZipcodeFinder).to receive(:new).with(@garden_2.zip_code).and_return(garden_2_zip_code)
      
        high_prob = double("high probability")
        low_prob = double("low probability")
        allow_any_instance_of(Weather).to receive(:initialize).with(@garden_1).and_return(@garden_1)
        allow_any_instance_of(Weather).to receive(:initialize).with(@garden_2).and_return(@garden_2)
        allow_any_instance_of(Weather).to receive(:initialize).with(@garden_3).and_return(@garden_3)
        allow(high_prob).to receive(:chance_of_rain).and_return(80)
        allow(low_prob).to receive(:chance_of_rain).and_return(30)
      
        results = RainyDay.generate_rainy_days
        expect(results.size).to eq(1)
        expect(results.first.gardens).to eq([@garden_1])
      end
    end
    it 'zip_codes' do
      user_1 = create(:user)
      create(:garden, owners: [user_1])
      user_2 = create(:user, telephone: '23482398')
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
      user_2 = create(:user, telephone: '23482398')
      @garden_1 = create(:garden, owners: [user_2], zip_code: "80000")
      @garden_2 = create(:garden, owners: [user_2], zip_code: "80125")
      @garden_3 = create(:garden, owners: [user_2], zip_code: "80125")
      # allow_any_instance_of(ZipcodeFinder).to receive(:latitude).and_return(100)
      # allow_any_instance_of(ZipcodeFinder).to receive(:longitude).and_return(100)
      allow_any_instance_of(Weather).to receive(:chance_of_rain).with(0).and_return(70)
      @rainy_days = RainyDay.generate_rainy_days
    end
    it 'gardens' do
      expect(@rainy_days.last.gardens.to_set).to eq(Set[@garden_3, @garden_2])
      expect(@rainy_days.first.gardens).to eq([@garden_1])
    end
  end
end
