@javascript
Feature: Task list feature
  As a student
  I want to view the task list of an exercise

  Scenario: Student can view the task list of an exercise
    Given I have logged in as a student
    And cases and tasks have been created
    When I visit the "Toimenpiteet" page of the case "Lihanautakuolemat"
    Then the page should have button "Soita lääkärille"