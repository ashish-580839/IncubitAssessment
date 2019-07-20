class ApplicationController < ActionController::Base

  rescue_from NotAuthorizedError, with: :user_not_authorized

  def index
    redirect_to current_user if current_user.present?
  end

private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authenticate_user
    redirect_to login_url, alert: "You are not authorized to access this page. Please log in" if current_user.nil?
  end

  def user_not_authorized
    redirect_to root_url, notice: "You are not authorized to perform this action."
  end

end
