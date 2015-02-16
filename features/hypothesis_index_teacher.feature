Feature: Hypothesis list feature
  As a teacher
  I want to view the hypothesis list of an exercise

  Scenario: Teacher can view the hypothesis list of an exercise
    Given I have logged in as a teacher
    And exercises have been added
    And hypothesis groups have been added
    #Hypotheses without a group assigned will not be shown
    And hypotheses have been added to case
    And I go to the front page
    And I click on the button "Lihanautakuolemat"
    When I click on the link "Työhypoteesit"
    Then the page should have button "Nautaflunssa"

  Scenario: Teacher can create a new hypothesis
    Given I have logged in as a teacher
    And exercises have been added
    And hypothesis groups have been added
    And I go to the front page
    And I click on the button "Lihanautakuolemat"
    When I click on the link "Työhypoteesit"
    And I click on a button "+ Uusi työhypoteesi"
    And I fill in name field with correct value
    And I click on the corresponding button "Tallenna"
    Then the new hypothesis should be created

  Scenario: Teacher can add hypothesis to a case
    Given I have logged in as a teacher
    And exercises have been added
    And hypothesis groups have been added
    And hypotheses have been created
    And I go to the front page
    And I click on the button "Lihanautakuolemat"
    When I click on the link "Työhypoteesit"
    And I click on a hypothesis button
    Then the hypothesis should be added to the case

 Scenario: Teacher remove hypothesis from a case

 Scenario: Teacher can update the explanation of a hypothesis

 Scenario: Teacher can create a new hypothesis group

