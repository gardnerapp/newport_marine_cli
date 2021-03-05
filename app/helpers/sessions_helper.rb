module SessionsHelper

  # logins a given user
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user(user)
    if session[:user_id] == user.id
      @current_user ||= User.find_by(id: session[:user_id])
      # validate again if admin if not set to nil
      # scenario uses web browser to create user then set session
    end
  end

  # is user logged in?
  # Make sure it only allows admins
  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete[:user_id]
    @current_user = nil
  end

end
