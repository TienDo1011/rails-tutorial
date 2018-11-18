@javascript
Feature: Micropost
  As an user
  I want to post micropost
  So that I can show my thinking

  Background:
    Given I have an account
    And I sign in

  Scenario: Create post with invalid information
    When I visit the home page
    Then I see the "Post" button
    When I click on the "Post" button
    Then I see error
    And No new micropost has been created

  Scenario: Create post with valid information
    When I visit the home page
    Then I see the "Post" button
    When I fill in post content
    And I click on the "Post" button
    Then I see my new post
    And I see the number of post updated
    And The post input is cleared
    When I refresh the page
    Then I still see my new post

  Scenario: View post information
    Given There is a micropost created 2 days ago
    When I visit the home page
    Then I see the micropost in feed

  Scenario: Delete post
    Given I have a micropost
    When I visit the home page
    Then I see my post
    When I click on delete
    Then I do not see my post
    When I refresh the page
    Then I still do not see my post
