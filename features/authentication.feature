@javascript
Feature: Authentication
  As an user
  I want to sign in
  So that I can enjoy the app more

  Background:
    Given There is an user

  Scenario: Sign in with invalid information
    When I visit sign in page
    And I click on "Sign in" button
    Then I see sign in error
    Then I visit another page
    And I do not see error

  Scenario: Sign in with valid information
    When I visit sign in page
    And I fill in user sign in information
    And I click on "Sign in" button
    Then I see navbar for login user
    Then I sign out
    Then I am back to sign in page

  Scenario: Un-sign in users visit protected page
    When I visit the following page
    Then I am redirected back to sign in
    When I visit the followers page
    Then I am redirected back to sign in
    When I visit the users index page
    Then I am redirected back to sign in

  Scenario: Signed in users visit protected page
    Given I signed in
    Then I am on profile page
