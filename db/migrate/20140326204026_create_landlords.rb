#This will create or drop the table with the string and timestamp to represent landlords
class CreateLandlords < ActiveRecord::Migration
  def up
    create_table :landlords do |landlords|
      landlords.string :name
      landlords.integer :rating_count
      landlords.decimal :average_rating
      landlords.timestamps
    end
  end

  def down
    drop_table :landlords
  end
end
