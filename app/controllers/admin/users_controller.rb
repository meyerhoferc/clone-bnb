class Admin::UsersController < ApplicationController
  def index
    @users = User.where.not(id: current_user.id)
  end

  def update
    @user = User.find(params[:id])
    if @user.update(status: params[:status])
      flash[:success] = "User #{@user.id} status now #{params[:status]}"
      redirect_to admin_users_path
    else
      flash[:error] = "Action not successful"
      render :index
    end
  end
end
