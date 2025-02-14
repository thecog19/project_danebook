class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login

  private

  def sign_in(user)
    user.regenerate_auth_token
    cookies[:auth_token] = user.auth_token
    @user = user
    @current_user = user
  end

  def permanent_sign_in(user)
    user.regenerate_auth_token
    cookies.permanent[:auth_token] = user.auth_token
    @current_user = user
  end

  def sign_out
    @current_user = nil
    cookies.delete(:auth_token)
  end

  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user

  def signed_in_user?
    !!current_user
  end
  helper_method :signed_in_user?

   def require_login
    unless signed_in_user?
      flash[:warning] = "Please sign in or sign up to see this page!"
      redirect_to new_user_path
    end
  end

  def require_logged_out
    if signed_in_user?
      flash[:warning] = "You already have an account!"
      redirect_to current_user
    end
  end

  def is_friend?(user)
    user.friended_users.any? {|friend| friend == current_user}
  end

end
