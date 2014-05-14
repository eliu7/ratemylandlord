#This will create or drop the table containg the ratings for every landlord
class CreateRatings < ActiveRecord::Migration
  def up
    create_table :ratings do |rating|
      rating.integer :user_id
      rating.integer :landlord_id
      
      rating.integer :general
      rating.integer :helpfulness
      rating.integer :friendliness
      rating.integer :availability

      rating.string :comment

      rating.timestamps
    end
  end

  def down
    drop_table :ratings
  end
end
