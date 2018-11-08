@javascript
Feature: Authentication
  As an user
  I want to sign in
  So that I can enjoy the app more

  Background:
    Given I have an account

  Scenario: Sign in with invalid information
    When I visit sign in page
    And I click on the "Sign in" button
    Then I see sign in error
    Then I visit the home page
    And I do not see error

  Scenario: Sign in with valid information
    When I visit sign in page
    And I fill in user sign in information
    And I click on the "Sign in" button
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
    Given I sign in
    And I am on the home page
    When I click on "Account" link
    And I see "Sign out" link
    When I visit the profile page
    Then I see "Update your profile"
