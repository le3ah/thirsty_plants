require "rails_helper"

describe RainyDay do
  it 'exists' do
    rd = RainyDay.new(chance: 80, zip_code: '32984')
    expect(rd).to be_a(RainyDay)
  end
  describe 'class methods' do

    it '.gardens_to_check_weather_for' do
      user_1 = create(:user)
      create(:garden, user: user_1)
      user_2 = create(:user, telephone: '23482398')
      garden_1 = create(:garden, user: user_2)
      garden_2 = create(:garden, user: user_2)
      expect(RainyDay.gardens_to_check_weather_for).to eq([garden_1, garden_2])
    end

    describe ".generate_rainy_days" do
      before(:each) do
        user_1 = create(:user)
        create(:garden, user: user_1)
        user_2 = create(:user, telephone: '23482398')
        @garden_1 = create(:garden, user: user_2, zip_code: "80000")
        garden_2 = create(:garden, user: user_2, zip_code: "80125")
        garden_3 = create(:garden, user: user_2, zip_code: "80125")
        allow_any_instance_of(ZipcodeFinder).to receive(:latitude).and_return(100)
        allow_any_instance_of(ZipcodeFinder).to receive(:longitude).and_return(100)
      end
      it 'on a rainy day' do
        allow_any_instance_of(Weather).to receive(:chance_of_rain).with(0).and_return(70)
        results = RainyDay.generate_rainy_days
        expect(results.size).to eq(2)
        expect(results.first).to be_a(RainyDay)
        expect(results.first.chance_of_rain).to eq(70)
        expect(results.first.zip_code).to eq(@garden_1.zip_code)
      end
      it 'on a not rainy enough day' do
        allow_any_instance_of(Weather).to receive(:chance_of_rain).with(0).and_return(49)
        results = RainyDay.generate_rainy_days
        expect(results.size).to eq(0)
      end
    end
    it 'zip_codes' do
      user_1 = create(:user)
      create(:garden, user: user_1)
      user_2 = create(:user, telephone: '23482398')
      garden_1 = create(:garden, user: user_2, zip_code: "80000")
      garden_2 = create(:garden, user: user_2, zip_code: "80125")
      garden_3 = create(:garden, user: user_2, zip_code: "80125")
      expect(RainyDay.zip_codes).to eq([garden_1.zip_code, garden_2.zip_code])
    end
    it 'returns all users whose gardens will be having a rainy day (50% or greater rain chance)' do

    end
  end
  describe 'instance methods' do
    before(:each) do
      user_1 = create(:user)
      create(:garden, user: user_1)
      user_2 = create(:user, telephone: '23482398')
      @garden_1 = create(:garden, user: user_2, zip_code: "80000")
      @garden_2 = create(:garden, user: user_2, zip_code: "80125")
      @garden_3 = create(:garden, user: user_2, zip_code: "80125")
      allow_any_instance_of(ZipcodeFinder).to receive(:latitude).and_return(100)
      allow_any_instance_of(ZipcodeFinder).to receive(:longitude).and_return(100)
      allow_any_instance_of(Weather).to receive(:chance_of_rain).with(0).and_return(70)
      @rainy_days = RainyDay.generate_rainy_days
    end
    it 'gardens' do
      expect(@rainy_days.last.gardens).to eq([@garden_3, @garden_2])
      expect(@rainy_days.first.gardens).to eq([@garden_1])
    end
  end
end
