@javascript
Feature: Complete task feature
  As a student
  I want to complete a task from a task list

  Scenario: Student can complete a text task from a task list
  	Given I have logged in as a student
  	And some tasks have been added to case
  	When I visit the "Toimenpiteet" page of the case "Lihanautakuolemat"
  	And I choose a text task "Soita lääkärille"
  	Then the task can be completed by clicking the button "Jatka"


