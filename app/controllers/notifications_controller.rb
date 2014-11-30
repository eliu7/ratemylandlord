#Controller for the landlord list and each individual landlord page
class NotificationsController < ApplicationController
  def index
    if require_admin
      pagesize = 10
      @page = (params[:page] || '1').to_i
      @reviews = Notification.ratings

      @count = @reviews.count
      @reviews = @reviews.limit(pagesize).offset((@page-1)*10)
      @page_count = (@count-1)/pagesize+1

      @range = [((@page-1)*pagesize+1),@count].min..[@page*pagesize, @count].min
    end
  end

  def update
    delete_ratings = []
    delete_notifications = []
    params.each do |key, value|
      if key =~ /mode_(\d+)/
        mode = value['action']
        next if mode == 'ignore'

        rating_id = $1.to_i

        delete_notifications << rating_id
        delete_ratings << rating_id if mode == 'delete'
      end
    end

    unless delete_notifications.empty?
      Notification.where(:rating_id => delete_notifications).delete_all

      Rating.skip_callback(:destroy, :before, :delete_notification)
      Rating.where(:id => delete_ratings).destroy_all
      Rating.set_callback(:destroy, :before, :delete_notification)
    end
    redirect_to notifications_path(:page => (params[:page] || 1))
  end
end
