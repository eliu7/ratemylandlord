#Rating model
class Rating < ActiveRecord::Base
  after_save     :on_save
  before_destroy :on_destroy
  around_update :on_update

  #Gets the rating categories
  def self.categories
    [:general, :helpfulness, :friendliness, :availability]
  end

  def average
    (general + helpfulness + friendliness + availability)/4.0
  end

  #Gets the landlord that this rating is for
  def landlord
    Landlord.find_by_id(landlord_id)
  end

  #Gets the user that submitted the rating
  def user
    User.find_by_id(user_id)
  end

private
  def on_save
    logger.info "Saving rating!!!"
    landlord = self.landlord
    landlord.add_rating(self) if landlord
  end

  def on_destroy
    logger.info "Destroying rating!!!"
    landlord = self.landlord
    landlord.remove_rating(self) if landlord
  end

  def on_update
    logger.info "Updating rating!!!"
    landlord = self.landlord
    landlord.remove_rating(self) if landlord

    old = Rating.new
    Rating.categories.each { |cat| old[cat] = self[cat] }

    yield

    landlord.update_rating(old, self) if landlord
  end
end
