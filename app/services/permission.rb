class Permission
  attr_reader :user, :controller, :action
  def initialize(user)
    @user = user || User.new
  end

  def allow?(controller, action)
    @controller = controller
    @action     = action
    if user.admin?
      admin_user_permissions
    elsif user.host?
      host_user_permissions
    elsif user.traveler?
      traveler_user_permissions
    else
      guest_user_permissions
    end
  end

  def guest_user_permissions
    return true if controller == "sessions"
    return true if controller == "home"
    return true if controller == "users"
    return true if controller == "listings"
    return true if controller == "reservations"
  end

  def host_user_permissions
    return true if controller == "sessions"
    return true if controller == "home"
    return true if controller == "users"
    return true if controller == "trips"
    return true if controller == "reservations"
    return true if controller == "dashboard"
    return true if controller == "listings/reviews"
    return true if controller == "reviews"
    return true if controller == "listings"
    return true if controller == "reservations"
    return true if controller == "conversations"
    return true if controller == "messages"
    return true if controller == "user/listings"


  end

  def traveler_user_permissions
    return true if controller == "sessions"
    return true if controller == "home"
    return true if controller == "users"
    return true if controller == "trips"
    return true if controller == "dashboard"
    return true if controller == "listings/reviews"
    return true if controller == "reviews"
    return true if controller == "listings"
    return true if controller == "reservations"

    return true if controller == "conversations"
    return true if controller == "messages"
  end

  def admin_user_permissions
    return true if controller == "admin/dashboard"
    return true if controller == "admin/users"
    return true if controller == "sessions"
    return true if controller == "listings"
    return true if controller == "admin/listings"
  end
end
