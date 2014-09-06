class CreateText < ActiveRecord::Migration
  def up
    create_table :texts do |text|
      text.string :name
      text.string :text
    end
  end

  def down
    drop_table :texts
  end
end
