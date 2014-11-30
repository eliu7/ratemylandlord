class CreateNotification < ActiveRecord::Migration
  def up
    create_table :notifications do |notifications|
      notifications.integer :rating_id
      notifications.timestamps
    end
  end

  def down
    drop_table :notifications
  end
end
