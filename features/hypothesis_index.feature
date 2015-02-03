Feature: Hypothesis list feature
  As a user
  I want to view the hypothesis list of an exercise

  Scenario: User can view the hypothesis list of an exercise
    Given I am on the front page with preexisting exercises which have hypotheses
    And I click on the link "Lihanautakuolemat"
    When I click on the link "Työhypoteesit"
    Then the page should show the content "Nautaflunssa"