Feature: New exercise feature
  As a teacher
  I want to create a new exercise

  Scenario: Teacher can create an exercise
    Given I have logged in as a teacher
    And I go to the front page
    And I click on the button "Luo uusi"
    And I fill in all the fields with correct input values
    When I press the button "Tallenna"
    Then page should have a message: "Casen luominen onnistui!"
    And the exercise should be in the database

  Scenario: Teacher cannot create an exercise with incorrect input values
    Given I have logged in as a teacher
    And I go to the front page
    And I click on the button "Luo uusi"
    And I do not fill in all the fields with correct input values
    When I press the button "Tallenna"
    Then page should have a message: "Seuraavat virheet estivät tallennuksen:"
    And the exercise should not be in the database