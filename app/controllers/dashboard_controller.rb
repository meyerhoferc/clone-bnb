class DashboardController < ApplicationController
  def show
    render file: "public/404" unless current_user
  end
end
