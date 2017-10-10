module SessionsHelper
  # log in as a given user
  def log_in(user)
    session[:user_id] = user.id
  end
  # return the currently logged in user
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  # check if the current user is logged in
  def logged_in?
    !current_user.nil?
  end
  # Logs out the current user.
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  # remember method
  def remember(user)
    user.remember # generate a token for the current user
    cookie.permanent.signed[:user_id] = user.id # create the cookie
    cookie.permanent[:remember_token] = user.remember_token # set the remember token on this cookie
  end
end
