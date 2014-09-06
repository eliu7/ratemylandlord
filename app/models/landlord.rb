#Landlord model
class Landlord < ActiveRecord::Base
  after_destroy :remove_ratings

  # Gets all of the ratings for the landlord
  def ratings(page = nil)
    ratings = Rating.where(:landlord_id => id).order('created_at DESC')
    return ratings unless page
    logger.info "Page not nil, is #{page}"
    return ratings.limit(10).offset((page-1)*10)
  end

  # Calculates the average ratings for the landlord
  def average_ratings
    avgs = Hash.new(0)
    categories = Rating.categories
    rs = ratings
    rs.each do |rate|
      categories.each { |cat| avgs[cat] += rate.send(cat) }
    end

    avgs.each { |k, v| avgs[k] = rs.empty? ? 0 : (v.to_f/rs.length).round(1) }

    categories.map { |cat| avgs[cat] }
  end

  def add_rating(rating)
    logger.info "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    logger.info "Added rating!"
    logger.info "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    self.average_rating = (self.average_rating*self.rating_count+rating.average)/
                          (self.rating_count+1)
    self.rating_count+=1
    self.save
  end

  def remove_rating(rating)
    logger.info "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    logger.info "Removed rating!"
    logger.info "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    self.average_rating = (self.average_rating*self.rating_count-rating.average)
    self.rating_count-=1
    self.average_rating = (self.rating_count == 0) ? 0 :
                          self.average_rating/self.rating_count
    self.save
  end

  def update_rating(old, new)
    logger.info "-----------------------------"
    logger.info "I am #{self.inspect}"
    logger.info "Update:\n#{old.inspect}\n#{new.inspect}"
    logger.info "Average: #{self.average_rating}\nCount: #{self.rating_count}"
    self.average_rating = (self.average_rating*self.rating_count-old.average+new.average)/self.rating_count
    logger.info "Updated:"
    logger.info "I am #{self.inspect}"
    logger.info "Average: #{self.average_rating}\nCount: #{self.rating_count}"
    logger.info "-----------------------------"
    self.save
  end

  def self.search_from(string, from)
    from.where('LOWER(name) LIKE :s', :s => "%#{string.downcase}%")
  end

  # Searches for landlords whose name contains the given string
  # results are sorted by the position of the string in the name
  def self.search(string)
    # Ignore case
    string = string.downcase
    landlords = Landlord.where("LOWER(name) LIKE :s", :s => "%#{string}%")

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

private
  def remove_ratings
    #Calling delete instead of destroy to prevent the callback
    self.ratings.delete_all
  end
end
