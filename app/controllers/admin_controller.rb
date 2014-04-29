class AdminController < ApplicationController
  def index
    if require_admin
      @admins = User.where(:admin => true)
    end
  end
  def revoke
    user = User.find(params[:id])
    user.admin = false
    user.save
    redirect_to(admin_path)
  end
end
