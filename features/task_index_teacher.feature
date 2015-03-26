Feature: Task list feature
  As a teacher
  I want to change order of tasks

  Scenario: Teacher can movea task upwards
    Given I have logged in as a teacher
    And cases and tasks have been created
    When I visit the "Toimenpiteet" page of the case "Lihanautakuolemat"
    And I click on the fancy-ass chevron up beside button "Lääkitse hevonen"
    Then the page should have the button "Lääkitse hevonen" topmost

 Scenario: Teacher can move a task downwards
 	Given I have logged in as a teacher
 	And cases and tasks have been created
 	When I visit the "Toimenpiteet" page of the case "Lihanautakuolemat"
 	And I click on the down chevron beside button "Lääkitse hevonen"
 	Then the page should have the button "Lääkitse hevonen" bottommost