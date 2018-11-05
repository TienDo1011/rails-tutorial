@javascript
Feature: Authentication
  As an user
  I want to sign in
  So that I can enjoy the app more

  Background:
    Given There is an user
    And There are some microposts
    And There is another user following the first user
    And I signed in

  Scenario: Visit home page
    When I visit the home page
    Then I see user's feed
    And I see user's follower/following counts
