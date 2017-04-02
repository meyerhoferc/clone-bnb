class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  before_action :authorize!

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_permission
    @current_permission ||= Permission.new(current_user)
  end

  def authorize!
    unless authorized?
      render file: "public/404"
    end
  end

  def authorized?
    current_permission.allow?(params[:controller], params[:action])
  end

  def admin_login
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password]) && user.admin?
      session[:user_id] = user.id
      "Logged in as #{user.first_name} #{user.last_name}"
      redirect_to admin_dashboard_path
    end
  end
end
