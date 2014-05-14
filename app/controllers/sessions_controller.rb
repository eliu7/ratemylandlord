class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    if user
      session[:user_id] = user.id
    else
      flash[:loginerror] = "You must provide a binghamton email to log in"
    end
    redirect = session.delete(:redirect) || '/'
    redirect_to redirect
  end

  def destroy
    logger.info "Redirect: #{params[:redirect].inspect}"
    session[:user_id] = nil
    redirect_to (params[:redirect] || root_path)
  end

  def signin
    session[:redirect] = params[:redirect]
    redirect_to '/auth/google_oauth2'
  end
end
