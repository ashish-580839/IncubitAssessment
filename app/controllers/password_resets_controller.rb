class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email].try(:downcase))
    if user.present?
      user.send_password_reset_mail
      redirect_to root_url, notice: "An email has been sent with password reset instructions"
    else
      flash.now.alert = "Email address not found"
      render action: :new
    end
  end


  def edit
    @user = User.find_by!(reset_password_token: params[:id])
  end

  def update
    @user = User.find_by!(reset_password_token: params[:id])
    if @user.password_reset_expired?
      redirect_to new_password_reset_path, alert: "Password reset has expired!" and return
    end

    if @user.update(update_params)
      @user.set_reset_fields_to_nil
      reset_session
      redirect_to root_url, notice: "Password has been reset! Please login"
    else
      render action: :edit
    end
  end

private

  # Never trust parameters from the scary internet, only allow the white list through.
  def update_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
