class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :admin?

  # Returns the current user
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # Returns true if the user is signed in as an admin
  def admin?
    current_user && current_user.admin
  end

  # If the user is not an admin, redirect to another page and return false
  # otherwise return true
  def require_admin(page = '/')
    unless admin?
      flash[:error] = 'You must be an admin to access that page'
      redirect_to page
      return false
    end
    return true
  end

  # If the user is not signed in, redirect to another page and return false
  # otherwise return true
  def require_sign_in(page = '/')
    if current_user.nil?
      flash[:error] = 'You must be signed in to access that page'
      redirect_to page
      return false
    end
    return true
  end
end
