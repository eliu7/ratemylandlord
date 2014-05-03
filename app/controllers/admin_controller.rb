class AdminController < ApplicationController
  def index
    if require_admin
      @admins = User.where(:admin => true)
      @nonadmins = User.where(:admin => false)
    end
  end
  def revoke
    if require_admin
      user = User.find(params[:id])
      user.admin = false
      user.save
      redirect_to(admin_path)
    end
  end

  def make
    if require_admin
      user = User.find(params[:id])
      user.admin = true
      user.save
      redirect_to(admin_path)
    end
  end
end
