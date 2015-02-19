Feature: Hypothesis list feature
  As a student
  I want to view the hypothesis list of an exercise

  Scenario: Student can view the hypothesis list of an exercise
    Given I have logged in as a student
    And some hypotheses have been added to case
    And I go to the case "Lihanautakuolemat"
    When I click on the link "Työhypoteesit"
    Then the page should have buttons
      | Nautaflunssa |
      | Hevosheikkous |