class AdminController < ApplicationController
  def index
    @admins = User.where(:permissions => true);
  end
end
