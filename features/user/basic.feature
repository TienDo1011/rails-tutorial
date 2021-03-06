@javascript
Feature: User
  As an user
  I want to use some basic feature
  So that I can enjoy the app

  Scenario: View index page
    Given I have an account
    And I sign in
    And There are 30 users
    When I visit users page
    Then I see "All users"
    And I see pagination
    And I see list of users
    And I do not see "delete" link

  Scenario: View profile page
    Given I have an account
    And I sign in
    And I have 2 microposts
    When I visit my profile page
    Then I see my name
    And I see all micropost contents
    And I see total micropost count

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

  Scenario: Signup
    When I visit signup page
    Then I see "Sign up"
    And I click on the "Create my account" button
    Then I see error
    When I fill in valid sign up information
    And I click on the "Create my account" button
    Then I am on the home page
    When I click on the menu icon
    And I click on "Account" link
    Then I see "Sign out" link

  Scenario: Signup with duplicate user name
    Given There is an user with user name "example"
    When I visit signup page
    Then I see "Sign up"
    When I fill in valid sign up information
    And I fill in user name with "example"
    And I click on the "Create my account" button
    Then I see error "user_name has already been taken"
    When I fill in user name with "example_1"
    And I fill in email with "example_1@admin.com"
    And I click on the "Create my account" button
    Then I am on the home page

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
