#This will create or drop the table containg the users for the ratemylandlord site
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |user|
      user.string :provider
      user.string :uid
      user.string :name
      user.string :email
      user.string :oauth_token
      user.boolean :admin
      user.datetime :oauth_expires_at

      user.timestamps
    end
  end
end
