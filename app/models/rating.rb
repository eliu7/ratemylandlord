#Rating model
class Rating < ActiveRecord::Base
  after_save     :on_save, :unless => :skip_save_callback
  before_destroy :on_destroy

  attr_accessor :skip_save_callback

  skip_callback :save, :after,

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

  def update_info(params)
    logger.info '-----------STUFF!-----------'
    logger.info "Params: #{params.inspect}"
    newRating = Rating.new
    Rating.categories.each do |cat|
      newRating[cat] = params[cat]
    end
    landlord = self.landlord
    landlord.update_rating(self, newRating) if landlord
  end

private
  def on_save
    logger.info '------AFTER SAVE--------'
    landlord = self.landlord
    landlord.add_rating(self) if landlord
  end

  def on_destroy
    logger.info '------BEFORE DESTROY--------'
    landlord = self.landlord
    landlord.remove_rating(self) if landlord
  end

#  def on_update
#    logger.info '------AROUND UPDATE--------'
#    landlord = self.landlord
#    landlord.remove_rating(self) if landlord
#
#    old = Rating.new
#    Rating.categories.each { |cat| old[cat] = self[cat] }
#
#    logger.info "Old: #{self.inspect}"
#    yield
#    logger.info "New: #{self.inspect}"
#
#    #landlord.add_rating(self) if landlord
#
#    #landlord.update_rating(old, self) if landlord
#  end
end
