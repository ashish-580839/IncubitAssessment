class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user.try(:authenticate, params[:password])
      session[:user_id] = user.id
      redirect_to user, notice: "Logged in!"
    else
      flash.now.alert = "Invalid email/password combination"
      render action: new
    end
  end

  def destroy
  end
end
