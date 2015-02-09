Feature: Session
  As a user
  I want to log in and out of the system

  Scenario: Logged in student can log out
    Given I have logged in as a student
    And I go to the front page
    When I click on the button "Kirjaudu ulos"
    Then the page should have button "Kirjaudu sisään"

  Scenario: Logged in teacher can log out
    Given I have logged in as a teacher
    And I go to the front page
    When I click on the button "Kirjaudu ulos"
    Then the page should have button "Kirjaudu sisään"

  Scenario: Logged out user can sign up
    Given I am not logged in
    And I go to the front page
    When I click on the button "Luo uusi tunnus"
    And I fill in the form with correct values
    And I click on the button "Tallenna"
    Then the page should show the content "Tervetuloa Taudinpurkauspelin pariin"