Feature: Task list feature
  As a user
  I want to view the task list of an exercise

  Scenario: User can view the task list of an exercise
    Given I am on the front page with preexisting exercises which have tasks
    And I click on the link "Lihanautakuolemat"
    When I click on the link "Toimenpiteet"
    Then the page should show the content "Soita lääkärille"