class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user.present?
      user.send_password_reset_mail
      redirect_to root_url, notice: "An email has been sent with password reset instructions"
    else
      flash.now.alert = "No user found with this email"
      render action: :new
    end
  end


end
