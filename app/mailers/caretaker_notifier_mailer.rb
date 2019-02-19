class CaretakerNotifierMailer < ApplicationMailer
  def inform(user, friend_contact)
    @user = user
    mail(to: friend_contact, subject: "#{user.first_name} wants you to check out their gardens!")
  end

end
