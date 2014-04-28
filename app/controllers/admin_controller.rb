class AdminController < ApplicationController
  def index
    @admins = User.where(:permissions => true)
  end
  def revoke
    user = User.find(params[:id])
    user.permissions = false
    user.save
    redirect_to(admin_path)
  end
end
