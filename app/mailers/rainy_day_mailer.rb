class RainyDayMailer < ApplicationMailer
  def inform(user, garden, chance)
    @user = user
    @garden = garden
    @chance = chance
    @attribution = user.own_gardens.include?(garden) ? "your garden" : "#{user.first_name}'s garden"
    mail(to: user.email, subject: "Heads up!")
  end

end
