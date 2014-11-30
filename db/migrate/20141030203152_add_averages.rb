class AddAverages < ActiveRecord::Migration
  def up
    add_column :landlords, :avg_general, :decimal
    add_column :landlords, :avg_helpfulness, :decimal
    add_column :landlords, :avg_friendliness, :decimal
    add_column :landlords, :avg_availability, :decimal

    Landlord.reset_column_information
    Landlord.find_each do |landlord|
      landlord.calculate_averages
    end
  end

  def down
    remove_column :landlords, :avg_general
    remove_column :landlords, :avg_helpfulness
    remove_column :landlords, :avg_friendliness
    remove_column :landlords, :avg_availability
  end
end
