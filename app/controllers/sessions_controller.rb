class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email].try(:downcase))
    if user.try(:authenticate, params[:password])
      session[:auth_token] = user.auth_token
      redirect_to user, notice: "Logged in!"
    else
      flash.now.alert = "Invalid email/password combination"
      render action: :new
    end
  end

  def destroy
    reset_session
    redirect_to root_url, notice: "Logged out!"
  end
end
