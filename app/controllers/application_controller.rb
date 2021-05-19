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

  def ensure_signed_in!
    render json: 'Must be signed in', status: 403 if !current_user
  end
end
