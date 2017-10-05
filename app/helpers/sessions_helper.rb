module SessionsHelper
  # log in as a given user
  def log_in(user)
    session[:user_id] = user.id
  end
  # return the currently logged in user
  def current_user
    @user ||= User.find_by(id: session[:user_id])
  end
  # check if the current user is logged in
  def logged_in?
    !current_user.nil?
  end
end
