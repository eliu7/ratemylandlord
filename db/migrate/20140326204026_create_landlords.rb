#This will create or drop the table with the string and timestamp to represent landlords
class CreateLandlords < ActiveRecord::Migration
  def up
    create_table :landlords do |person|
      person.string :name
      person.integer :rating_count
      person.decimal :average_rating
      person.timestamps
    end
  end

  def down
    drop_table :landlords
  end
end
