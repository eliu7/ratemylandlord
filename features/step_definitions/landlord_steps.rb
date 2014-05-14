Given /the following ratings exist/ do |ratings_table|
  ratings_table.hashes.each do |rating|
    Rating.create!(rating)
  end
end

Given /the following landlords exist/ do |landlord_table|
  landlord_table.hashes.each do |llord|
    Landlord.create!(llord)
  end
end

When /^I type "(.*?)" in the search bar and search$/ do |search_name|
  Landlord.search(search_name)
end

Then /^(?:|I )should see "([^"]*)" and their ratings$/ do |name|
  if page.respond_to? :should
    page.should have_content(name)
  else
    assert page.has_content?(name)
  end
end

Then /^(?:|I )should see all the landlords$/ do
  landlords = Landlord.all
  assert landlords.count == 2
end

When /I leave a comment "([^"]*)"$/ do |comment|
  fill_in("comment_Leave a comment", :with => value)
end

Given /I am logged in to the site/ do
  visit "/signin"
#"auth/google_oauth2"
=begin  session[:user_id] = 1
  if page.respond_to? :should
    page.should have_content("Signed in as")
  else
    assert page.has_content?("Signed in as")
  end
=end
end
