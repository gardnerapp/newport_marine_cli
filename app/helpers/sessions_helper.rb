module SessionsHelper
  def log_in(user)
    # return valid information for the app here then redner as JSON
    session[:user_id] = user.id
  end

  def current_user?(user)
    user && user == current_user
  end

  def logged_in?
    !current_user?.nil?
  end

  def api_login(user)
    render json: user
  end

end
