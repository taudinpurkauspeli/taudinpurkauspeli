@javascript
Feature: User show feature
  As a student
  I want to view my own page

  Scenario: Student can view his page
    Given I have logged in as a student
    And cases and tasks have been created
    When I click on the link "Omat tiedot"
    Then the page should show my information

  Scenario: Student can view started cases
    Given I have logged in as a teacher
    And some tasks have been added to case
    And I have completed some tasks
    When I go to see my own page
    Then I should see my progress