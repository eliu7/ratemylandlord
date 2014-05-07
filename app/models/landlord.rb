class Landlord < ActiveRecord::Base
  #Gets all of the ratings for the landlord
  def ratings(page = nil)
    ratings = Rating.where(landlord_id: id).order('created_at DESC')
    return ratings if page.nil?
    return ratings.limit(20).offset((page-1)*20)
  end

  #Calculates the average ratings for the landlord
  def average_ratings
    avgs = Hash.new(0)
    categories = Rating.categories
    rs = ratings
    rs.each do |r|
      categories.each { |c| avgs[c] += r.send(c) }
    end

    avgs.each { |k, v| avgs[k] = rs.empty? ? 0 : (v.to_f/rs.length).round(1) }

    categories.map { |c| avgs[c] }
  end

  #Searches for landlords whose name contains the given string
  # results are sorted by the position of the string in the name
  def self.search(string)
    string = string.downcase
    landlords = Landlord.where("LOWER(name) LIKE :search", search: "%#{string}%")
    sorted = []
    landlords.each do |l|
      newname = l.name.downcase.split.reverse.join(' ')
      pos = newname.index(string)
      next if pos.nil?
      sorted << [l, pos]
    end
    sorted.sort! { |a, b| a[1] <=> b[1] }
    sorted.map {|a| a[0] }
  end
end
