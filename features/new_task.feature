@javascript
Feature: New task feature
  As a teacher
  I want to create a new task

  Scenario: Teacher can create a task without a subtask
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
    And I click on the button "+ Luo uusi toimenpide"
    When I fill in task name
    And I press the button "Tallenna"
    And I press the button "+ Teksti"
    And I fill in task text content
    And I press the button "Tallenna"
    Then page should show the new task text content
    And task text should be in the database

  Scenario: Teacher can create a task with multichoice
    Given I have logged in as a teacher
    And Cases have been created
    And I visit the "Toimenpiteet" page of the case "Lihanautakuolemat"
    And I press the button "+ Luo uusi toimenpide"
    When I fill in task name
    And I press the button "Tallenna"
    And I press the button "+ Monivalinta tai radio button"
    And I fill in multichoice question
    And I press the button "Tallenna"
    Then page should have a message: "Kysymys lisättiin onnistuneesti!"
    And multichoice should be in the database

  Scenario: Teacher can create a task with multichoice and option
    Given I have logged in as a teacher
    And Cases have been created
    And Task with a multichoice has been created
    And I visit the "Toimenpiteet" page of the case "Lihanautakuolemat"
    When I go to the multichoice edit page
    And I fill in option content
    And I fill in option explanation
    And I press the button "Tallenna"
    Then page should have a message: "Vaihtoehto lisättiin onnistuneesti."
    And option should be in the database

  Scenario: Teacher can create a task with radiobutton
    Given I have logged in as a teacher
    And Cases have been created
    And I visit the "Toimenpiteet" page of the case "Lihanautakuolemat"
    And I press the button "+ Luo uusi toimenpide"
    When I fill in task name
    And I press the button "Tallenna"
    And I press the button "+ Monivalinta tai radio button"
    And I fill fill in radiobutton question and select radiobutton option
    And I press the button "Tallenna"
    Then page should have a message: "Kysymys lisättiin onnistuneesti!"
    And radiobutton should be in the database

  Scenario: Teacher can create a task with radiobutton and one right option
    Given I have logged in as a teacher
    And Cases have been created
    And Task with a radiobutton has been created
    And I visit the "Toimenpiteet" page of the case "Lihanautakuolemat"
    When I go to the radiobutton edit page
    And I fill in option content, explanation and select right answer box
    And I press the button "Tallenna"
    Then page should have a message: "Vaihtoehto lisättiin onnistuneesti."
    And right radiobutton option should be in the database

Scenario: Teacher can create a task with interview
    Given I have logged in as a teacher
    And Cases have been created
    And I visit the "Toimenpiteet" page of the case "Lihanautakuolemat"
    And I press the button "+ Luo uusi toimenpide"
    When I fill in task name
    And I press the button "Tallenna"
    And I press the button "+ Pohdinta"
    And I fill in interview title
    And I press the button "Tallenna"
    Then page should show the new interview title
    And interview should be in the database

Scenario: Teacher can create a task with interview and questions
    Given I have logged in as a teacher
    And Cases have been created
    And Task with interview has been created
    And I visit the "Toimenpiteet" page of the case "Lihanautakuolemat"
    When I go to the interview edit page
    And I fill in question title and content
    And I press the button "Tallenna"
    # page should show the new question title
    And question should be in the database
