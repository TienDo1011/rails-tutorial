@javascript
Feature: User
  As an admin user
  I want to use some admin priviledge features
  So that I can control the app

  Scenario: Admin user delete user
    Given There are 30 users
    And I am an admin user
    And I sign in
    When I visit users page
    Then I see first user delete link
    When I delete first user
    Then I do not see the first user
    When I refresh the page
    Then I still do not see the first user

  Scenario: Admin user can not delete himself
    Given I am an admin user
    And I sign in
    When I visit users page
    Then I do not see admin user delete link
