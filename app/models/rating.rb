class Rating < ActiveRecord::Base
  def landlord
    Landlord.find(landlord_id)
  end
  def user
    User.find(user_id)
  end
end
