class Rating < ActiveRecord::Base
  #Gets the rating categories
  def self.categories
    [:general, :helpfulness, :friendliness, :availability]
  end

  #Gets the landlord that this rating is for
  def landlord
    Landlord.find(landlord_id)
  end

  #Gets the user that submitted the rating
  def user
    User.find(user_id)
  end
end
