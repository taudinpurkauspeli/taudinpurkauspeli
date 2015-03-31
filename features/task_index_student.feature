@javascript
Feature: Task list feature
  As a student
  I want to view the task list of an exercise

  Scenario: Student can view the task list of an exercise
    Given I have logged in as a student
    And cases and tasks have been created
    When I visit the "Toimenpiteet" page of the case "Lihanautakuolemat"
    Then the page should have button "Soita lääkärille"

  Scenario: Student can view done task_text
    Given I have logged in as a student
    And some task texts have been added to case
    And one task with text task is completed
    When I visit the "Toimenpiteet" page of the case "Lihanautakuolemat"
    And I click on the button "Soita lääkärille"
    Then the page should show the task text content

  Scenario: Student can view done multichoice
    Given I have logged in as a student
    And some multichoices have been added to case
    And one task with multichoice is completed
    When I visit the "Toimenpiteet" page of the case "Lihanautakuolemat"
    And I click on the button "Lääkitse hevonen"
    Then the page should show the information about completed multichoice

  Scenario: Student can view done radiobutton
    Given I have logged in as a student
    And some radiobuttons have been added to case
    And one task with radiobutton is completed
    When I visit the "Toimenpiteet" page of the case "Lihanautakuolemat"
    And I click on the button "Lääkitse hevonen"
    Then the page should show the information about completed radiobutton