#Notification model
class Notification < ActiveRecord::Base
  def self.ratings
    Rating.joins('INNER JOIN notifications on notifications.rating_id = ratings.id ORDER BY notifications.id DESC')
  end
end
