@javascript
Feature: User
  As an user
  I want to follow/unfollow other user
  So that I can control who I'm following

  Scenario: Following a user
    Given There is another user
    And I have an account
    And I sign in
    When I visit that user profile page
    And I click on the "Follow" button
    Then I see the "Unfollow" button
    And I see the number of followers is 1
    When I visit my profile page
    Then I see the number of followed users is 1

  Scenario: Unfollowing a user
    Given I have an account
    And I sign in
    And I follow another account
    When I visit that user profile page
    And I click on the "Unfollow" button
    Then I see the "Follow" button
    And I see the number of followers is 0
    When I visit my profile page
    Then I see the number of followed users is 0

  Scenario: Receive notification via email
    Given I have an account with notify new follower via email switch on
    And There is another user
    And Another user sign in
    When He visits my page
    And He click on the "Follow" button
    Then I receive an email telling me that new user has followed me

  Scenario: Do not receive notification via email
    Given I have an account with notify new follower via email switch off
    And There is another user
    And Another user sign in
    When He visits my page
    And He click on the "Follow" button
    Then I do not receive any email
