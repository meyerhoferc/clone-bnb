class Permission
  attr_reader :user, :controller, :action
  def initialize(user)
    @user = user || User.new
  end

  def allow?(controller, action)
    @controller = controller
    @action     = action

    if user.traveler?
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
  end

  def traveler_user_permissions
    return true if controller == "sessions"
    return true if controller == "home"
    return true if controller == "users"
    return true if controller == "dashboard"
    return true if controller == "listings"
    return true if controller == "reservations"
  end

  def host_user_permissions
    return true if controller == "sessions"
    return true if controller == "home"
    return true if controller == "users"
    return true if controller == "dashboard"
    return true if controller == "listings"
  end
end
