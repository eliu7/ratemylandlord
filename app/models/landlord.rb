class Landlord < ActiveRecord::Base
  #Returns all of the ratings for the landlord
  def ratings
    Rating.where(landlord_id: id)
  end

  #Calculates the average rating for the landlord
  def average_ratings
    avgs = Hash.new(0)
    categories = [:general, :helpfulness, :friendliness, :availability]
    rs = ratings
    rs.each do |r|
      categories.each { |c| avgs[c] += r.send(c) }
    end

    avgs.each { |k, v| avgs[k] = rs.empty? ? 0 : v/rs.length }

    return avgs
  end
end
