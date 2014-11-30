#Landlord model
class Landlord < ActiveRecord::Base
  # Remove all ratings for the landlord when it's removed
  after_destroy :remove_ratings

  def self.rating_functions
    Rating.categories.map do |cat|
      [cat.to_s, "avg_#{cat.to_s}"]
    end.map do |(cat, get)|
      [cat, get, "#{get}="]
    end
  end

  # Gets all of the ratings for the landlord
  def ratings(page = nil)
    ratings = Rating.where(:landlord_id => id).order('created_at DESC')
    return ratings unless page
    logger.info "Page not nil, is #{page}"
    return ratings.limit(10).offset((page-1)*10)
  end

  # Calculates the average ratings for the landlord
  def average_ratings
    Landlord.rating_functions.map { |(_, get, _)| self.send(get) }
  end

  def calculate_average_rating
    ratings = self.average_ratings
    self.average_rating = ratings.reduce(:+) / ratings.size
  end

  def calculate_averages
    functions = Landlord.rating_functions

    rs = self.ratings

    functions.each { |(_,_,set)| self.send(set, 0) }
    self.rating_count = rs.count

    rs.each do |rating|
      functions.each do |(cat, get, set)|
        self.send(set, self.send(get) + rating.send(cat))
      end
    end

    if self.rating_count > 0
      functions.each do |(_, get, set)|
        self.send(set, self.send(get)/self.rating_count)
      end
    end
    self.calculate_average_rating
    self.save
  end

  def merge(landlord)
    return if self.id == landlord.id
    unless self.rating_count.zero? && landlord.rating_count.zero?
      Landlord.rating_functions.each do |(_, get, set)|
        self.send(set, (self.send(get)*self.rating_count +
                        landlord.send(get)*landlord.rating_count) /
                       (self.rating_count + landlord.rating_count))
      end
    end
    self.rating_count+=landlord.rating_count
    self.calculate_average_rating
    self.save

    landlord.ratings.update_all(:landlord_id => self.id)

    landlord.destroy
  end

  def add_rating(rating)
    Landlord.rating_functions.each do |(cat, get, set)|
      self.send(set, (self.send(get)*self.rating_count+rating.send(cat)) /
                     (self.rating_count+1))
    end
    self.rating_count+=1
    self.calculate_average_rating
    self.save
  end

  def remove_rating(rating)
    if (self.rating_count > 1)
      Landlord.rating_functions.each do |(cat, get, set)|
        self.send(set, (self.send(get)*self.rating_count-rating.send(cat)) /
                       (self.rating_count-1))
      end
      self.rating_count-=1
      self.calculate_average_rating
      self.save
    else
      self.destroy
    end
  end

  def update_rating(old, new)
    Landlord.rating_functions.each do |(cat, get, set)|
      self.send(set, (self.send(get)*self.rating_count-old.send(cat)+new.send(cat)) /
                     self.rating_count)
    end
    self.calculate_average_rating
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
    logger.info '--------------LANDLORD DESTROY---------------'
    self.ratings.delete_all
  end
end
