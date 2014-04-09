class LoginController < ApplicationController
  def login
    user = User.find_by_email(params[:login][:email])
    if user.nil?
      error
    else
      pass = User.hash_pass(params[:login][:password])
      if user.password == pass
        session[:user] = {id: user.id, email: user.email, permissions: user.permissions}
      else
        error
      end
    end
    redirect_to params[:redirect]
  end

  def logout
    session[:user] = nil
    redirect_to params[:redirect]
  end

  def error
    flash[:loginerror] = "Invalid bmail or password"
  end
end
