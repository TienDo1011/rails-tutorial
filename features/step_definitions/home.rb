And(/There are some microposts/) do
  create(:micropost, user: @user, content: "Lorem ipsum")
  create(:micropost, user: @user, content: "Dolor sit amet")
end

Then(/I see user's feed/) do
  @user.feed.each do |item|
    expect(page).to have_selector("li", text: item.content)
  end
end

And(/I see user's follower\/following counts/) do
  expect(page).to have_content("0 followings")
  expect(page).to have_content("1 followers")
end

And(/^There is another user following me$/) do
  @another_user = create(:user)
  @another_user.follow!(@user)
end

When /(I|He) visit the home page/ do |_|
  visit "/"
end

And /I make a reply to another user/ do
  @reply = "@#{@another_user.user_name} Lorem ipsum"
  fill_in 'micropost-content', with: @reply
  click_button "Post"
end

Then /(I|He) see that reply in (my|his) feed/ do |_, _|
  expect(page).to have_content(@reply)
end

Given /Another user sign in/ do
  page.execute_script("localStorage.clear()")
  visit "/signin"
  fill_in "Email", with: @another_user.email
  fill_in "Password", with: @another_user.password
  click_button "Sign in"
end
