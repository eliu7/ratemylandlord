#Rating model
class Rating < ActiveRecord::Base
  after_save :update_landlord_info

  #Gets the rating categories
  def self.categories
    [:general, :helpfulness, :friendliness, :availability]
  end

  def average
    (general + helpfulness + friendliness + availability)/4.0
  end

  #Gets the landlord that this rating is for
  def landlord
    Landlord.find(landlord_id)
  end

  #Gets the user that submitted the rating
  def user
    User.find(user_id)
  end

private
  def update_landlord_info
    self.landlord.update_rating_info(self)
  end
end
