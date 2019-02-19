class RainyDayTexter < ApplicationTexter

  def self.rainy_day_text(garden, chance)
    {
      from: TwillioAccountPhoneNumber,
      to: "+1#{garden.user.telephone}",
      body: "Heads up from Thirsty Plants! There is a #{chance}% chance of precipitation today in your garden #{garden.name} at #{garden.zip_code}."
    }
  end
end
