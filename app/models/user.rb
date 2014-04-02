require 'digest/sha1'

class User < ActiveRecord::Base
  #Hash the password before saving it
  before_save { self.password = Digest::SHA1.hexdigest(self.password) }

  def ratings
    Rating.where(user_id: id)
  end
end
