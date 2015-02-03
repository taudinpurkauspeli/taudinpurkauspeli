Feature: User can read the anamnesis of a exercise
  As a user
  I want to view the anamnesis of an exercise

  Scenario: User can view the anamnesis of an exercise
    Given I am on the front page with preexisting exercises which have anamneses
    When I click on the link "Lihanautakuolemat"
    Then the page should show the content "Lihanautoja on menehtynyt lukuisia"