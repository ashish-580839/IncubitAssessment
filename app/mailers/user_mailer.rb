class UserMailer < ApplicationMailer
  default from: 'help@example.com'

  def welcome_email(user_id)
    @user = User.find(user_id)

    mail to: @user.email, subject: "Signup Confirmation"
  end
end
