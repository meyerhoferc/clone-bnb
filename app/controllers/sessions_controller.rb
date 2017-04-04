class SessionsController < ApplicationController
  before_action :admin_login, only: [:create]
  before_action :check_user_status, only: [:create]

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Logged in as #{user.first_name} #{user.last_name}"
      redirect_to dashboard_path
    else
      flash.now[:error] = "Email or password has been entered incorrectly"
      render :new
    end
  end

  def destroy
    session.clear
    flash[:success] = "Logged out successfully"
    redirect_to root_path
  end
end
