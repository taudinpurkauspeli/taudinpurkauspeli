Feature: Exercises page
  As a user
  I want to visit the exercises page

  Scenario: User visits exercises page
    Given no exercises have been added
    When I go to the page that shows exercises
    Then the page should show the content "Taudinpurkauspeli"

