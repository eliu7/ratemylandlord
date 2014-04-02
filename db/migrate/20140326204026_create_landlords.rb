class CreateLandlords < ActiveRecord::Migration
  def up
    create_table :landlords do |t|
      t.string :name
      t.timestamps
    end
  end

  def down
    drop_table :landlords
  end
end
