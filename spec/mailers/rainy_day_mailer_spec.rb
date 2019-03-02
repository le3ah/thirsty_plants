require "rails_helper"
describe RainyDayMailer do
  describe 'class methods' do

    it 'inform' do
      user = create(:user)
      user_2 = create(:user)
      garden = create(:garden, owners: [user], caretakers: [user_2])
      chance = 90
      mail = RainyDayMailer.inform(user, garden, chance)

      expect(mail.to).to eq([user.email])
      expect(mail.subject).to eq("Heads up!")
      expect(mail.from).to eq(["no-reply@thirstyplants.com"])

      expect(mail.body.encoded).to match("Here comes the rain again!")
      expect(mail.body.encoded).to match("There is a #{chance }% chance of precipitation today in your garden #{garden.name } at #{garden.zip_code }.")
      expect(mail.body.encoded).to match("Don't over water!")
      mail = RainyDayMailer.inform(user_2, garden, chance)

      expect(mail.body.encoded).to match("Here comes the rain again!")
      expect(mail.body.encoded).to match("There is a #{chance }% chance of precipitation today in #{user.first_name}'s garden #{garden.name } at #{garden.zip_code }.")
      expect(mail.body.encoded).to match("Don't over water!")
    end
  end
end
