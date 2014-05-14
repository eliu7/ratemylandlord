#Landlord model
class Landlord < ActiveRecord::Base
  # Gets all of the ratings for the landlord
  def ratings(page = nil)
    ratings = Rating.where(landlord_id: id).order('created_at DESC')
    return ratings unless page
    return ratings.limit(10).offset((page-1)*10)
  end

  # Calculates the average ratings for the landlord
  def average_ratings
    avgs = Hash.new(0)
    categories = Rating.categories
    ratesset = ratings
    ratesset.each do |rate|
      categories.each { |catigory| avgs[catigory] += rate.send(catigory) }
    end

    avgs.each { |k, v| avgs[k] = ratesset.empty? ? 0 : (v.to_f/ratesset.length).round(1) }

    categories.map { |catigory| avgs[catigory] }
  end

  # Searches for landlords whose name contains the given string
  # results are sorted by the position of the string in the name
  def self.search(string)
    # Ignore case
    string = string.downcase
    landlords = Landlord.where("LOWER(name) LIKE :s", s: "%#{string}%")

    reverse = !(string.include? ' ')
    logger.info "Reverse: #{reverse}"

    # Get 
    sorted = []
    landlords.each do |lord|
      newname = lord.name.downcase
      # Reverse last names with first names ('John Doe' -> 'Doe John')
      newname = newname.split.reverse.join(' ') if reverse
      pos = newname.index(string)
      next if pos.nil? # This shouldn't happen
      sorted << [lord, pos]
    end
    
    # Sort by search position
    sorted.sort! { |a, b| a[1] <=> b[1] }
    sorted.map {|a| a[0] }
  end
end
