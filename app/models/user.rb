require 'digest/sha1'

class User < ActiveRecord::Base
  #Hashes a password
  def self.hash_pass(password)
    Digest::SHA1.hexdigest(password);
  end

  #Hash the password before saving it
  before_save { self.password = User.hash_pass(self.password); }

  #Gets all of the ratings the user submitted
  def ratings
    Rating.where(user_id: id)
  end
end
