Feature: New task feature
  As a teacher
  I want to create a new task

  Scenario: Teacher can create a task without task text
    Given I have logged in as a teacher
    And Cases have been created
    And I visit the "Toimenpiteet" page of the case "Lihanautakuolemat"
    And I click on the link "Luo uusi toimenpide"
    When I fill in task name
    And I press the button "Tallenna"
    Then page should have a message: "Toimenpiteen luominen onnistui!"
    And new task should be in the database

  Scenario: Teacher can create a task with task text
    Given I have logged in as a teacher
    And Cases have been created
    And I visit the "Toimenpiteet" page of the case "Lihanautakuolemat"
    And I click on the link "Luo uusi toimenpide"
    When I fill in task name and task text content
    And I press the button "Tallenna"
    Then page should have a message: "Toimenpiteen luominen onnistui!"
    And new task and task text should be in the database
