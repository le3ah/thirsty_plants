require "rails_helper"
describe RainyDayTexter do
  describe 'class methods' do

    it 'rainy_day_text' do
      garden = create(:garden)
      chance = 80

      expected_text = {
        from: '+12028834286',
        to: "+1#{garden.users.first.telephone}",
        body: "Heads up from Thirsty Plants! There is a #{chance}% chance of precipitation today in your garden #{garden.name} at #{garden.zip_code}."
      }
      expect(RainyDayTexter.rainy_day_text(garden.users.first, garden, chance)).to eq(expected_text)
    end

    it 'admin_text' do
      scheduled_time = 1.day.from_now

      expected_text = {
        from: '+12028834286',
        to: "+1#{ENV['ADMIN_PHONE_NUMBER']}",
        body: "Thirsty Plants has scheduled RainyDayJob for #{scheduled_time}"
       }
      expect(RainyDayTexter.admin_text(scheduled_time)).to eq(expected_text)
    end
  end
end
