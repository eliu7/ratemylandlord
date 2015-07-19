class ChangeRatings < ActiveRecord::Migration
  def up
    rename_column :landlords, :avg_friendliness, :avg_professionalism
    rename_column :landlords, :avg_availability, :avg_credibility
    rename_column :ratings, :general, :general_1
    rename_column :ratings, :helpfulness, :helpfulness_1
    rename_column :ratings, :friendliness, :professionalism_1
    rename_column :ratings, :availability, :credibility_1
    add_column :ratings, :general_2, :integer
    add_column :ratings, :helpfulness_2, :integer
    add_column :ratings, :professionalism_2, :integer
    add_column :ratings, :credibility_2, :integer

    add_column :ratings, :oldreview, :boolean	
    Rating.find_each do |rating|
      rating.general_2 = -1
      rating.helpfulness_2 = -1
      rating.professionalism_2 = -1
      rating.credibility_2 = -1
      rating.oldreview = true
      rating.save!
    end
  end

  def down
    rename_column :landlords, :avg_professionalism, :avg_friendliness
    rename_column :landlords, :avg_credibility, :avg_availability
    rename_column :ratings, :general_1, :general
    rename_column :ratings, :helpfulness_1, :helpfulness
    rename_column :ratings, :professionalism_1, :friendliness
    rename_column :ratings, :credibility_1, :availability


    remove_column :ratings, :general_2
    remove_column :ratings, :helpfulness_2
    remove_column :ratings, :professionalism_2
    remove_column :ratings, :credibility_2

    remove_column :ratings, :oldreview
  end

end
