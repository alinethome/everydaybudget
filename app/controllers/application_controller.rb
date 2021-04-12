class ApplicationController < ActionController::Base
  helper_method :current_user

  def sign_in!(user)
    session[:session_token] = user.session_token
  end

  def sign_out!(user)
    session[:session_token] = nil
    user.reset_session_token!
  end

  def current_user
    User.find_by(session_token: session[:session_token])
  end
end
