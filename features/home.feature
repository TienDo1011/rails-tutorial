@javascript
Feature: Home page
  As an user
  I want to view the home page
  So that I can read feeds and some statistics

  Background:
    Given I have an account
    And There are some microposts
    And I sign in

  Scenario: Visit home page
    Given There is another user following me
    When I visit the home page
    Then I see user's feed
    And I see user's follower/following counts

  Scenario: Making @replies
    Given There is another user
    When I visit the home page
    And I make a reply to another user
    Then I see that reply in my feed
    Given Another user sign in
    When He visit the home page
    Then He see that reply in his feed
