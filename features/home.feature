@javascript
Feature: Home page
  As an user
  I want to view the home page
  So that I can read feeds and some statistics

  Background:
    Given I have an account
    And There are some microposts
    And There is another user following me
    And I sign in

  Scenario: Visit home page
    When I visit the home page
    Then I see user's feed
    And I see user's follower/following counts
