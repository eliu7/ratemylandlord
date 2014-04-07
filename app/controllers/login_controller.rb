class LoginController < ApplicationController
  def login
    user = User.find_by_email(params[:login][:email])
    unless user.nil?
      pass = User.hash_pass(params[:login][:password])
      session[:user] = user.email if user.password == pass
    end
    redirect_to params[:redirect]
  end

  def logout
    session[:user] = nil
    redirect_to params[:redirect]
  end
end
