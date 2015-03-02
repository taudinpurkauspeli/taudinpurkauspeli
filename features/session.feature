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
    Then the page should show the content "Käyttäjätunnuksen luominen onnistui!"

  Scenario: Logged out user with existing account can log in
    Given I am not logged in
    And I have a user account
    And I go to the front page
    When I enter my username and password
    And I click on the button "Kirjaudu sisään"
    Then the page should show the content "Tervetuloa"