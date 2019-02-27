class UnwateredNotifierMailer < ApplicationMailer
  def inform(user)
    @user = user
    mail(to: user.email, subject: "Water you thinking!?")
  end
end
