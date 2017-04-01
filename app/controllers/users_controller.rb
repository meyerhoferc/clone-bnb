class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    @user.roles.create(title: "traveler")
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
      flash[:success] = "Successfully logged in as #{@user.first_name} #{@user.last_name}"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    render file: "public/404" unless @user == current_user

  end

  def update
    @user = current_user
    @user.update_role(params[:user][:role])
    @user.update_attributes(user_params)
    flash[:success] = "Account successfully updated"
    redirect_to dashboard_path

  end

  private

  def user_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :email,
                                 :password,
                                 :about_me,
                                 :phone_number)
  end
end
