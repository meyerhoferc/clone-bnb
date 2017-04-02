class Admin::DashboardController < ApplicationController
  def show
    # render file: "public/404" unless current_user && current_user.admin?
  end
end
