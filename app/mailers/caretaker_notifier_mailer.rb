class CaretakerNotifierMailer < ApplicationMailer
  def inform(user, friend_contact, garden)
    @user = user
    mail(to: friend_contact, subject: "#{user.first_name} wants you to caretake their gardens!")
  end

end
