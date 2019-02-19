require "rails_helper"
describe RainyDayTexter do
  describe 'class methods' do

    it 'send_rainy_day_text' do
      garden = create(:garden)
      chance = 80

      expected_text = {
        from: '+12028834286',
        to: "+1#{garden.user.telephone}",
        body: "Heads up from Thirsty Plants! There is a #{chance}% chance of precipitation today in your garden #{garden.name} at #{garden.zip_code}."
      }
      expect(RainyDayTexter.rainy_day_text(garden, chance)).to eq(expected_text)
    end
  end
end
