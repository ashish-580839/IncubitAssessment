class ApplicationController < ActionController::Base

  rescue_from NotAuthorizedError, with: :user_not_authorized

  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

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

  def record_not_found(error)
    render :file => "#{Rails.root}/public/404.html",  layout: false, status: :not_found
  end

end
