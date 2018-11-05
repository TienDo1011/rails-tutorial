Given /There is an user/ do
  @user = create(:user)
end

When /I visit sign in page/ do
  visit "/signin"
end

And /I click on "([\w\s]+)" button/ do |text|
  click_button text
end

Then /I see sign in error/ do
  expect(page).to have_content("Sign in")
  expect(page).to have_selector('div.alert.alert-danger')
end

Then /I visit the home page/ do
  click_link "Home"
end

And /I do not see error/ do
  expect(page).to have_no_selector('div.alert.alert-danger')
end

And /I fill in user sign in information/ do
  fill_in "Email", with: @user.email
  fill_in "Password", with: @user.password
end

Then /I see navbar for login user/ do
  expect(page).to have_content('Account')
  expect(page).to have_no_content('Sign in')
end

Then /I sign out/ do
  click_on "Account"
  click_on "Sign out"
end

Then /I am back to sign in page/ do
  expect(page).to have_content('Sign in')
end

When /I visit the following page/ do
  visit "users/#{@user.id}/followings"
end

Then /I am redirected back to sign in/ do
  expect(page).to have_content('Sign in')
end

When /I visit the followers page/ do
  visit "users/#{@user.id}/followers"
end

When /I visit the users index page/ do
  visit "/users"
end

Given /I signed in/ do
  visit "/users/#{@user.id}/edit"
  fill_in "Email", with: @user.email
  fill_in "Password", with: @user.password
  click_button "Sign in"
end

Then /I am on profile page/ do
  expect(page).to have_content('Update your profile')
  page.execute_script("localStorage.clear()")
end
