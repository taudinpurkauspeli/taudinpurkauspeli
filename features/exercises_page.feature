Feature: Exercises page
  As a user
  I want to visit the exercises page

  Scenario: Logged out user visits exercises page
    Given no exercises have been added
    When I go to the front page
    Then the page should show the content "Taudinpurkauspeli"
    And the page should have button "Kirjaudu sisään"
    And the page should have button "Luo uusi tunnus"

  Scenario: Logged out user visits exercises page
    Given exercises have been added
    When I go to the front page
    Then I should see the following buttons
      | Lihanautakuolemat |
      | Heikko hevonen |

  Scenario: Student can view the exercises page
    Given I have logged in as a student
    And exercises have been added
    When I go to the front page
    Then I should see the following buttons
      | Lihanautakuolemat |
      | Heikko hevonen |

  Scenario: Teacher can view the exercises page
    Given I have logged in as a teacher
    And exercises have been added
    When I go to the front page
    Then I should see the following buttons
      | Lihanautakuolemat |
      | Heikko hevonen |

