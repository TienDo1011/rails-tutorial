Given(/There are 30 users/) do
  30.times { create(:user) }
end

When(/I visit users page/) do
  visit "/users"
end

And(/I see pagination/) do
  expect(page).to have_selector('ul.pagination')
end

And(/I see list of users/) do
  User.limit(User::USERS_PER_PAGE).each do |user|
    expect(page).to have_selector('li', text:user.name)
  end
end

Given(/I am an admin user/) do
  @user = create(:admin)
end

Then(/I see first user delete link/) do
  id = User.first.id.to_s
  within "li[id='#{id}']" do
    expect(page).to have_link('Delete')
  end
end

When(/I delete first user/) do
  page.accept_confirm do
    click_link('Delete', match: :first)
  end
end

Then(/I (still )?do not see the first user/) do |_|
  expect(page).to have_no_link('delete', href: "users/#{User.first.id}")
end

Then(/I do not see admin user delete link/) do
  id = @user.id
  within "li[id='#{id}']" do
    expect(page).to have_no_link('Delete')
  end
end

Given(/I have (\d) microposts/) do |num|
  @microposts = num.to_i.times.map { create(:micropost, user: @user) }
end

When(/I visit my profile page/) do
  visit "/users/#{@user.id}"
end

Then(/I see my name/) do
  expect(page).to have_content(@user.name)
end

And(/I see all micropost contents/) do
  @microposts.map do |m|
    expect(page).to have_content(m.content)
  end
end

And(/I see total micropost count/) do
  expect(page).to have_content(@microposts.count)
end

Given(/^There is another user$/) do
  @another_user = create(:user)
end

When(/I visit that user profile page/) do
  visit "/users/#{@another_user.id}"
end

And(/I see the number of followers is (\d)/) do |num|
 expect(page).to have_content "#{num} followers"
end

Then(/I see the number of followed users is (\d)/) do |num|
 expect(page).to have_content "#{num} followings"
end

And(/I follow another account/) do
  @another_user ||= create(:user)
  @user.follow!(@another_user)
end

When(/I visit signup page/) do
  visit "/signup"
end

When(/I fill in valid sign up information/) do
  fill_in "Name", with: "Example User"
  fill_in "Email", with: "user@example.com"
  fill_in "Password", with: "foobar"
  fill_in "Confirmation", with: "foobar"
end

Then(/I see a "([\w\s]+)" (success|error) alert/) do |text, type|
  expect(page).to have_selector("div.alert.alert-#{type}", text: text)
end

When(/I fill in valid update profile info/) do
  @new_name = "New Name"
  fill_in "Name", with: @new_name
  fill_in "Email", with: "new@example.com"
  fill_in "Password", with: "foobar"
  fill_in "Confirm Password", with: "foobar"
end

Then(/I see my updated name/) do
  expect(page).to have_content(@new_name)
end

And(/I follow that account/) do
  @user.follow!(@another_user)
end

When(/I visit the followings page/) do
  visit "/users/#{@user.id}/followings"
end

And(/I see the link to that user account/) do
  expect(page).to have_link(@another_user.name, href: "/users/#{@another_user.id}")
end

When(/I visit that user followers page/) do
  visit "users/#{@another_user.id}/followers"
end

And(/I see the link to my account/) do
  expect(page).to have_link(@user.name, href: "/users/#{@user.id}")
end
