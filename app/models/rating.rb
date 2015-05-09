#Rating model
class Rating < ActiveRecord::Base
  after_save     :on_save, :unless => :skip_save_callback
  after_save     :add_notification
  before_destroy :on_destroy
  before_destroy :delete_notification

  attr_accessor :skip_save_callback

  #Gets the rating categories
  def self.categories
    [:general, :helpfulness, :professionalism, :credibility]
  end

  def self.questions
    [:general_1, :general_2, :helpfulness_1, :helpfulness_2, :professionalism_1, :professionalism_2, :credibility_1, :credibility_2]
  end

  def self.quesmap
    {:general_1 => "I would rent from this landlord again",
     :general_2 => "The landlord respected the terms of the lease agreement",
     :helpfulness_1 => "Requested repairs were completed promptly and adequately",
     :helpfulness_2 => "The landlord was easy to work with",
     :professionalism_1 => "The landlord communicated in a timely and professional manner",
     :professionalism_2 => "The landlord respected my privacy",
     :credibility_1 => "When I moved in, the condition of the rental property was what I expected",
     :credibility_2 => "The landlord conducted a proper move-out inspection and refunded my deposit accordingly"}
  end

  def average
    (general_1 + helpfulness_1 + professionalism_1 + credibility_1 + general_2 + helpfulness_2 + professionalism_2 + credibility_2)/8.0
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
    newRating.oldreview = false 
    self.oldreview = false #all newly edited reviews set this false
    Rating.questions.each do |subques|
      newRating[subques] = params[subques]
    end
    landlord = self.landlord
    landlord.update_rating(self, newRating) if landlord
  end

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

  def add_notification
    self.delete_notification
    Notification.create(:rating_id => self.id)
  end

  def delete_notification
    Notification.where(:rating_id => self.id).destroy_all
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
