def randstr(length)
  (0..length).map { (97+rand(26)).chr }.join
end

def randname
  first = randstr(rand(6)+4)
  last = randstr(rand(6)+4)
  "#{first.capitalize} #{last.capitalize}"
end

30.times do
  landlord = Landlord.new
  landlord.name = randname
  landlord.rating_count = 0
  landlord.average_rating = 0
  landlord.save

  num = rand(20)+5
  num.times do |i|
    rating = Rating.new
    Rating.categories.each { |cat| rating[cat] = rand(5)+1 }
    rating.landlord_id = landlord.id
    rating.user_id = 1
    rating.comment = "Comment #{i}"
    rating.save
  end
end
