@javascript
Feature: User can read the anamnesis of a exercise
  As a student
  I want to view the anamnesis of an exercise

  Scenario: Student can view the anamnesis of an exercise
    Given I have logged in as a student
    And exercises have been added
    When I go to the front page
    And I click on the button "Lihanautakuolemat"
    Then the page should show the content "Lihanautoja on menehtynyt lukuisia"

  Scenario: Student can view the anamnesis of any exercise
    Given I have logged in as a student
    And exercises have been added
    When I go to the front page
    And I click on the button "Heikko hevonen"
    Then the page should show the content "Hevosella on heikot polvet"