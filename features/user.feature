@javascript
Feature: User
  As an user
  I want to use the app
  So that I can enjoy it

  Scenario: View index page
    Given I have an account
    And I sign in
    And There are 30 users
    When I visit users page
    Then I see "All users"
    And I see pagination
    And I see list of users
    And I do not see "delete" link

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

  Scenario: View profile page
    Given I have an account
    And I sign in
    And I have 2 microposts
    When I visit my profile page
    Then I see my name
    And I see all micropost contents
    And I see total micropost count

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

  Scenario: Signup
    When I visit signup page
    Then I see "Sign up"
    And I click on the "Create my account" button
    Then I see error
    When I fill in valid sign up information
    And I click on the "Create my account" button
    Then I am on the home page
    When I click on "Account" link
    And I see "Sign out" link

  Scenario: Edit profile
    Given I have an account
    And I sign in
    When I visit the profile page
    Then I see "Update your profile"
    When I click on the "Save changes" button
    Then I see error
    When I fill in valid update profile info
    And I click on the "Save changes" button
    Then I see a "Profile updated" success alert
    When I visit the home page
    Then I see my updated name

  Scenario: View followings/followers
    Given I have an account
    And I sign in
    And There is another user
    And I follow that account
    When I visit the followings page
    Then I see "Followings"
    And I see the link to that user account
    When I visit that user followers page
    Then I see "Followers"
    And I see the link to my account
