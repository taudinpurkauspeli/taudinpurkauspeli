@javascript
Feature: Hypothesis list feature
  As a student
  I want to view the hypothesis list of an exercise

  Scenario: Student can view the hypothesis list of an exercise
    Given I have logged in as a student
    And some hypotheses have been added to case
    When I visit the "Työhypoteesit" page of the case "Lihanautakuolemat"
    Then the page should have buttons
      | Nautaflunssa |
      | Hevosheikkous |

  Scenario: Student cannot view the hypothesis list of an exercise if no exercise has been chosen
    Given I have logged in as a student
    And some hypotheses have been added to case
    When I try to visit the "Työhypoteesit" page of the case "Lihanautakuolemat"
    Then I should be redirected back to the front page
    And the page should show the content "Valitse ensin case, jota haluat tarkastella!"

  Scenario: Student can't check a hypothesis from an exercise when prerequisite task not done
    Given I have logged in as a student
    And hypotheses with prerequisite tasks have been added to case
    And I visit the "Työhypoteesit" page of the case "Lihanautakuolemat"
    When I click on the hypothesis button "Nautaflunssa"
    Then the page should show the content "Sinulla ei ole vielä"
    And "Nautaflunssa" should not be checked from exercise

  Scenario: Student can check a hypothesis from an exercise when prerequisite task done
    Given I have logged in as a student
    And hypotheses with prerequisite tasks have been added to case
    And I have completed all the tasks
    And I visit the "Työhypoteesit" page of the case "Lihanautakuolemat"
    When I click on the hypothesis button "Nautaflunssa"
    Then the page should show the content "poissuljettu"
    And "Nautaflunssa" should be checked from exercise

  Scenario: Unchecked hypotheses will be in alphabetical order
    Given I have logged in as a student
    And there is an exercise that has multiple hypotheses
    And I go to the hypothesis list of that exercise
    Then the hypothesis list should be in alphabetical order

  Scenario: Checked hypotheses will be in alphabetical order
    Given I have logged in as a student
    And there is an exercise that has multiple hypotheses
    And those hypotheses are all checked
    And I go to the hypothesis list of that exercise
    Then the hypothesis list should be in alphabetical order

