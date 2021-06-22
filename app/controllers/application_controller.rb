class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in? # lets us use these methods inside our views
  # skip_before_action :verify_authenticity_token

  def login(user)
    # saves the user's session_token into their browser's cookies
    session[:session_token] = user.reset_session_token!
    @current_user = user
  end

  def current_user
    return nil if session[:session_token].nil?
    # looks up which user has the session_token that is stored in the browser's cookies
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user # !!value returns "true" if the value is truthy or "false" if it is falsey
    # you could also use !current_user.nil?
  end

  def logout!
    current_user.reset_session_token! if logged_in?
    session[:session_token] = nil
    @current_user = nil
  end

  def require_logged_in
    redirect_to new_session_url unless logged_in?
  end

  def require_logged_out
    redirect_to users_url if logged_in?
  end

end
