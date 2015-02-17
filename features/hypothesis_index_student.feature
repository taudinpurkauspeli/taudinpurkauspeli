Feature: Hypothesis list feature
  As a student
  I want to view the hypothesis list of an exercise

  Scenario: Student can view the hypothesis list of an exercise
    Given I have logged in as a student
    Given there are exercises and hypothesis groups
    And hypotheses have been added to case
    And I go to the front page
    And I click on the button "Lihanautakuolemat"
    When I click on the link "Työhypoteesit"
    Then the page should have button "Nautaflunssa"