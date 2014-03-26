class CreateRatings < ActiveRecord::Migration
  def up
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :landlord_id
      
      t.integer :general
      t.integer :helpfulness
      t.integer :friendliness
      t.integer :availability

      t.string :comment

      t.timestamps
    end
  end

  def down
    drop_table :ratings
  end
end
