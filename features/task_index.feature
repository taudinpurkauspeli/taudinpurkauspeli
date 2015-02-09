Feature: Task list feature
  As a student
  I want to view the task list of an exercise

  Scenario: Student can view the task list of an exercise
    Given I have logged in as a student
    And exercises have been added
    And tasks have been added
    When I go to the front page
    And I click on the button "Lihanautakuolemat"
    And I click on the link "Toimenpiteet"
    Then the page should show the content "Soita lääkärille"