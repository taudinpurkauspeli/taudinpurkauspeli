@javascript
Feature: Complete task feature
  As a student
  I want to complete a task from a task list

  Scenario: Student can complete a text task from a task list
    Given I have logged in as a student
    And some text tasks have been added to case
    When I visit the "Toimenpiteet" page of the case "Lihanautakuolemat"
    And I choose a text task "Soita lääkärille"
    Then the task can be completed by clicking the button "Jatka"

  Scenario: Student can complete a multichoice task from a task list
    Given I have logged in as a student
    And some multichoice tasks have been added to case
    When I visit the "Toimenpiteet" page of the case "Lihanautakuolemat"
    And I choose a multichoice task "Lääkitse hevonen"
    And I check the right options
    Then the task can be completed by clicking the button "Tarkista"

  Scenario: Student can complete a multichoice task with right and some allowed options selected
    Given I have logged in as a student
    And some multichoice tasks have been added to case
    When I visit the "Toimenpiteet" page of the case "Lihanautakuolemat"
    And I choose a multichoice task "Lääkitse hevonen"
    And I check the right and some allowed options
    Then the task can be completed by clicking the button "Tarkista"

  Scenario: Student cannot complete a multichoice task with wrong options selected
    Given I have logged in as a student
    And some multichoice tasks have been added to case
    When I visit the "Toimenpiteet" page of the case "Lihanautakuolemat"
    And I choose a multichoice task "Lääkitse hevonen"
    And I check wrong options
    Then the task cannot be completed by clicking the button "Tarkista"
    And I should see the message "Valinnoissa oli vielä virheitä!"
    And I should see the explanations for wrong options

  Scenario: Student cannot complete a multichoice task with no options selected
    Given I have logged in as a student
    And some multichoice tasks have been added to case
    When I visit the "Toimenpiteet" page of the case "Lihanautakuolemat"
    And I choose a multichoice task "Lääkitse hevonen"
    And I don't check any options
    Then the task cannot be completed by clicking the button "Tarkista"
    And I should see the message "Valinnoissa oli vielä virheitä!"

  Scenario: Student cannot complete a multichoice task when not all right options are selected
    Given I have logged in as a student
    And some multichoice tasks have been added to case
    When I visit the "Toimenpiteet" page of the case "Lihanautakuolemat"
    And I choose a multichoice task "Lääkitse hevonen"
    And I don't check all right options
    Then the task cannot be completed by clicking the button "Tarkista"
    And I should see the message "Valinnoissa oli vielä virheitä!"
    And I should see the explanations for checked options

  Scenario: Student can complete a radio button task from a task list
    Given I have logged in as a student
    And some radiobutton tasks have been added to case
    When I visit the "Toimenpiteet" page of the case "Lihanautakuolemat"
    And I choose a radiobutton task "Lääkitse hevonen"
    And I choose the right option
    Then the task can be completed by clicking the button "Tarkista"

  Scenario: Student cannot complete a radio button task with wrong option selected
    Given I have logged in as a student
    And some radiobutton tasks have been added to case
    When I visit the "Toimenpiteet" page of the case "Lihanautakuolemat"
    And I choose a radiobutton task "Lääkitse hevonen"
    And I choose a wrong option
    Then the task cannot be completed by clicking the button "Tarkista"
    And I should see the message "Valinnoissa oli vielä virheitä!"
    And I should see the explanation for wrong option

  Scenario: Student cannot complete a radio button task with allowed option selected
    Given I have logged in as a student
    And some radiobutton tasks have been added to case
    When I visit the "Toimenpiteet" page of the case "Lihanautakuolemat"
    And I choose a radiobutton task "Lääkitse hevonen"
    And I choose an allowed option
    Then the task cannot be completed by clicking the button "Tarkista"
    And I should see the message "Valinnoissa oli vielä virheitä!"
    And I should see the explanation for allowed option

  Scenario: Student cannot complete a radio button task with no option selected
    Given I have logged in as a student
    And some radiobutton tasks have been added to case
    When I visit the "Toimenpiteet" page of the case "Lihanautakuolemat"
    And I choose a radiobutton task "Lääkitse hevonen"
    And I don't choose any option
    Then the task cannot be completed by clicking the button "Tarkista"
    And I should see the message "Valinnoissa oli vielä virheitä!"

  Scenario: Student can complete an interview task from a task list
    Given I have logged in as a student
    And some interview tasks have been added to case
    When I visit the "Toimenpiteet" page of the case "Lihanautakuolemat"
    And I choose an interview task "Lääkitse hevonen"
    And I ask the required questions
    Then the task can be completed by clicking the button "Jatka"

  Scenario: Student can complete an interview task with allowed questions asked
    Given I have logged in as a student
    And some interview tasks have been added to case
    When I visit the "Toimenpiteet" page of the case "Lihanautakuolemat"
    And I choose an interview task "Lääkitse hevonen"
    And I ask the required and some allowed questions
    Then the task can be completed by clicking the button "Jatka"

  Scenario: Student can complete an interview task with wrong questions asked
    Given I have logged in as a student
    And some interview tasks have been added to case
    When I visit the "Toimenpiteet" page of the case "Lihanautakuolemat"
    And I choose an interview task "Lääkitse hevonen"
    And I ask the required and some wrong questions
    Then the task can be completed by clicking the button "Jatka"

  Scenario: Student cannot complete an interview task no questions asked
    Given I have logged in as a student
    And some interview tasks have been added to case
    When I visit the "Toimenpiteet" page of the case "Lihanautakuolemat"
    And I choose an interview task "Lääkitse hevonen"
    And I don't ask any questions
    Then the task cannot be completed by clicking the button "Jatka"
    And I should see the message "Et ole vielä valinnut kaikkia tarpeellisia vaihtoehtoja!"
