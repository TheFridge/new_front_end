class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_login

  helper_method :current_user

  def current_user
    if Rails.env == 'development' || Rails.env == 'test'
      User.first
    else
      User.find_or_create_by(:email => cookies.signed['email']) if cookies.signed['email']
    end
  end

  def require_login
    redirect_to login_path unless current_user
  end

end
