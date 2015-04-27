@javascript
Feature: User list feature
  As a teacher
  I want to view progress of students

  Scenario: Teacher can view all cases
    Given I have logged in as a teacher
    And cases and tasks have been created
    And I click on the button "Opiskelijoiden seuranta"
    And "Kaikki" option is selected from case list
    Then the page should show the content "Heikko hevonen"
    And the page should show the content "Lihanautakuolemat"

  Scenario: Teacher can view only one case
    Given I have logged in as a teacher
    And cases and tasks have been created
    And I click on the button "Opiskelijoiden seuranta"
    And "Lihanautakuolemat" option is selected from case list
    Then the page should not show the content "Heikko hevonen"
    And the page should show the content "Lihanautakuolemat"

  Scenario: Teacher can view progress of a student
    Given I have logged in as a teacher
    And some tasks have been added to case
    And a student has one task completed
    And I click on the button "Opiskelijoiden seuranta"
    And "Kaikki" option is selected from case list
    Then the page should show the content "50%"

  Scenario: Teacher can all students
    Given I have logged in as a teacher
    And some tasks have been added to case
    And students have created accounts
    And students have completed tasks
    And I click on the button "Opiskelijoiden seuranta"
    When I select "Opiskelijalista" to be shown
    Then the page should show all students