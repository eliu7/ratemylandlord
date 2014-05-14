Feature: Search for a landlord
  As a potential tenent
  So that I can view the ratings for a landlord
  I want to search for a landlord by name

Background: landlords are in the database
  Given the following landlords exist:
  |name|
  |Sue |
  |Iggy|

  Given the following ratings exist:
  |user_id|landlord_id|general|helpfulness|friendliness|availability|
  |1      |1          |3.0    |3.2        |2.3         |4.8         |
  |1      |2          |3.7    |4.0        |4.9         |4.1         |

Scenario: search for a landlord
  Given I am on the homepage
  When I fill in "search" with "Sue"
  And I press "go"
  Then I should be on the landlords page
  And I should see "Sue" and their ratings
  And I should not see "Iggy"

Scenario: view all landlords
  Given I am on the homepage
  When I fill in "search" with ""
  And I press "go"
  Then I should be on the landlords page
  And I should see all the landlords
