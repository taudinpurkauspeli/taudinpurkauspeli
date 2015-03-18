 Feature: New task feature
   As a teacher
   I want to create a new task

  Scenario: Teacher can create a task without task text
    Given I have logged in as a teacher
    And Cases have been created
    And I visit the "Toimenpiteet" page of the case "Lihanautakuolemat"
    And I click on the button "Luo uusi toimenpide"
    When I fill in task name
    And I press the button "Tallenna"
    Then page should have a message: "Toimenpide luotiin onnistuneesti."
   And new task should be in the database

  Scenario: Teacher can create a task with task text
    Given I have logged in as a teacher
    And Cases have been created
    And I visit the "Toimenpiteet" page of the case "Lihanautakuolemat"
    And I click on the button "Luo uusi toimenpide"
    When I fill in task name
    And I press the button "Tallenna"
    And I press the button "Luo uusi tekstimuotoinen alitoimenpide"
    And I fill in task text content
    And I press the button "Tallenna"
    Then page should show the new task text content
    And task text should be in the database

  Scenario: Teacher can create a task with multichoice
    Given I have logged in as a teacher
    And Cases have been created
    And I visit the "Toimenpiteet" page of the case "Lihanautakuolemat"
    And I press the button "Luo uusi toimenpide"
    When I fill in task name
    And I press the button "Tallenna"
    And I press the button "Luo uusi monivalinta-alitoimenpide"
    And I fill in multichoice question
    And I press the button "Tallenna kysymys"
    Then page should have a message: "Kysymys lisättiin onnistuneesti."
    And multichoice should be in the database

   Scenario: Teacher can create a task with multichoice and option
     Given I have logged in as a teacher
     And Cases have been created
     And I visit the "Toimenpiteet" page of the case "Lihanautakuolemat"
     And I press the button "Luo uusi toimenpide"
     When I fill in task name
     And I press the button "Tallenna"
     And I press the button "Luo uusi monivalinta-alitoimenpide"
     And I fill in multichoice question
     And I press the button "Tallenna kysymys"
     Then page should have a message: "Kysymys lisättiin onnistuneesti."
     And multichoice should be in the database
     And I fill in option content
     And I fill in option explanation
     And I press the button "Tallenna"
     Then page should have a message: "Vaihtoehto lisättiin onnistuneesti."
     And option should be in the database
