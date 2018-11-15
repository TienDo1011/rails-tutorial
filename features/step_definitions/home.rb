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
  other_user = create(:user)
  other_user.follow!(@user)
end

When /I visit the home page/ do
  visit "/"
end
