Feature: Add a new landlord
  As a student residing in Binghamton
  So that I can review my landlord
  I want to post a new rating for my landlord

@omniauth_test
Scenario:
  Given I am on the home page
  Given I am logged in to the site
  And I am on the new rating page
  Then I should see "rate this landlord"
  When I fill in "landlord_name" with "Al"
  When I select "3" from "general_General:"
  And I select "2" from "helpfulness_Helpfulness"
  And I select "2" from "friendliness_Friendliness"
  And I select "4" from "availability_Availability"
  And I leave a comment "he's ok"
  And I press "Create Landlord"
  Then I should be on the page for "Al"
  And I should see "Al"
