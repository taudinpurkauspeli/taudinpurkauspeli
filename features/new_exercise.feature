Feature: New exercise feature
  As a user
  I want to create a new exercise

  Scenario: User can create an exercise
    Given I am on the front page
    And I click on the link "Luo uusi"
    And I do fill in all the fields with correct input values
    When I press "Tallenna"
    Then page should have message: "Casen luominen onnistui!"
    And the exercise should be in the database

  Scenario: User cannot create an exercise
    Given I am on the front page
    And I click on the link "Luo uusi"
    And I do not fill in all the fields with correct input values
    When I press "Tallenna"
    Then page should have message: "prohibited this exercise from being saved"
    And the exercise should not be in the database