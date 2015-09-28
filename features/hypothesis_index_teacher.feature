@javascript
Feature: Hypothesis list feature
  As a teacher
  I want to view the hypothesis list of an exercise

  Scenario: Teacher can view the hypothesis list of an exercise
    Given I have logged in as a teacher
    And some hypotheses have been added to case
    When I visit the "Diffit" page of the case "Lihanautakuolemat"
    Then the page should have buttons
      | Nautaflunssa |
      | Hevosheikkous |

  Scenario: Teacher can create a new hypothesis
    Given I have logged in as a teacher
    And cases and hypothesis groups have been created
    And I visit the "Diffit" page of the case "Lihanautakuolemat"
    When I click on a button "+ Uusi työhypoteesi"
    And I fill in the hypothesis name field with a correct value
    And I save the new hypothesis with button "Tallenna"
    Then the new hypothesis should be created

  Scenario: Teacher cannot create a new hypothesis with wrong parameters
    Given I have logged in as a teacher
    And cases and hypothesis groups have been created
    And I visit the "Diffit" page of the case "Lihanautakuolemat"
    When I click on a button "+ Uusi työhypoteesi"
    And I fill in the hypothesis name field with an incorrect value
    And I save the new hypothesis with button "Tallenna"
    Then the new hypothesis should not be created

  Scenario: Teacher can add hypothesis to a case
    Given I have logged in as a teacher
    And cases, hypothesis groups and hypotheses have been created
    And I visit the "Diffit" page of the case "Lihanautakuolemat"
    When I click on the hypothesis button "Hevosheikkous"
    Then the hypothesis should be added to the case

  Scenario: Teacher can remove hypothesis from a case
    Given I have logged in as a teacher
    And some hypotheses have been added to case
    And I visit the "Diffit" page of the case "Lihanautakuolemat"
    When I click on one of the hypotheses of the case
    And I click on the delete button "Poista casesta"
    Then the hypothesis should be removed from the case

  Scenario: Teacher can update the explanation of a hypothesis
    Given I have logged in as a teacher
    And some hypotheses have been added to case
    And I visit the "Diffit" page of the case "Lihanautakuolemat"
    When I click on one of the hypotheses of the case
    And I fill in the explanation field
    And I save changes with button "Tallenna"
    Then the explanation should be added to the hypothesis

  Scenario: Teacher can change a prerequisite task to a hypothesis
    Given I have logged in as a teacher
    And hypotheses with prerequisite tasks have been added to case
    And I visit the "Diffit" page of the case "Lihanautakuolemat"
    When I click on one of the hypotheses of the case
    And I change the prerequisite task
    And I save changes with button "Tallenna"
    Then the prerequisite task of the hypothesis should be updated

  Scenario: Teacher can create a new hypothesis group
    Given I have logged in as a teacher
    And cases, hypothesis groups and hypotheses have been created
    And I visit the "Diffit" page of the case "Lihanautakuolemat"
    When I click on the button "+ Uusi työhypoteesiryhmä"
    And I fill in the hypothesis group name field with a correct name
    And I click on button "Tallenna"
    Then the new hypothesis group should be created

  Scenario: Hypotheses in the hypothesis bank will be in alphabetical order
    Given I have logged in as a teacher
    And cases and hypothesis groups have been created
    And there are multiple hypotheses that are not added to any exercise
    And I go to the hypothesis list of that exercise
    Then the teacher's hypothesis bank should be in alphabetical order
