#Create landlords
landlords = [
  "Kevin Johnson",
  "Adam Heimowitz",
  "Michael Zagreda"
]
landlords.each { |l| Landlord.create(name: l) }

#Create users
#users = [
#  #Email    Password    Permission
#  ["kevin", "password", true],
#  ["adam",  "password", true],
#  ["mike",  "password", false],
#]
#users.each { |(e, pw, p)| User.create(email: e, password: pw, permissions: p) }

#Create ratings
#ratings = [
#  #Landlord User  Ratings     Comment
#  [1,       1,    [4,3,5,2],  "He is super cool"],
#  [1,       2,    [1,1,1,1],  "He is stupid"],
#  [1,       3,    [5,4,3,2],  "I AM MIKE"]
#]
#ratings.each do |(l, u, (gen, help, friend, avail), c)|
#  Rating.create(landlord_id: l, user_id: u,
#                general: gen, helpfulness: help,
#                friendliness: friend, availability: avail,
#                comment: c)
#end
