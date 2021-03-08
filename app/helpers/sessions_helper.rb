module SessionsHelper

  # logins a given user
  def log_in(user)
    # only logs in users that are admins
    session[:user_id] = user.id if User.find_by(id: user.id)&.is_admin?
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
      # TODO scenario uses web browser to create user then set session
    end
  end

  # is user logged in?
  # if current_is exist & is_admin it exist
  def logged_in?
    !@current_user.nil?
  end

  def log_out
    session[:user_id] = nil
    @current_user = nil
  end

end
