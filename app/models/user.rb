#User model
class User < ActiveRecord::Base
  #Gets all of the ratings the user submitted
  def ratings
    Rating.where(:user_id => id)
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      return nil unless auth.info.email.include? '@binghamton.edu'
      user.provider = auth.provider
      user.uid = auth.uid
      user.admin = false unless !user.name && user.email
      user.name = auth.info.name
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end
